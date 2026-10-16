import sys,os,struct,json
COM={k:{int(a):b for a,b in v.items()} for k,v in json.load(open(os.path.join(os.path.dirname(__file__),'comments.json'))).items()}
PCOM={}
sys.path.insert(0,os.path.dirname(__file__))
from tpsplit import split

REG={0x03:'R',0x04:'PR',0x05:'P',0x0a:'DI',0x0f:'DO',0x16:'GI',0x17:'GO',0x29:'F',
     0x08:'UI',0x09:'UO',0x0b:'RI',0x0c:'RO',0x10:'SI',0x11:'SO',0x3e:'AR',0x21:'UFRAME',0x23:'UTOOL',0x2a:'SR',0x7f:'LBL',0x2b:'TIMER',0x2c:'TIMER_OVERFLOW'}
OPS={0x64:'=',0x65:'+',0x66:'-',0x67:'*',0x68:'/',0x69:' DIV ',0x6a:' MOD ',0x6b:'=',0x6c:'<>',0x6d:'<',0x6e:'<=',0x6f:'>',0x70:'>=',
     0x71:' AND ',0x72:' OR ',0x73:'(',0x74:')',0x75:'!'}
class P:
    def __init__(s,b): s.b=b; s.i=0
    def more(s): return s.i<len(s.b)
    def peek(s): return s.b[s.i] if s.i<len(s.b) else None
    def u8(s): v=s.b[s.i]; s.i+=1; return v
    def u16(s): v=(s.b[s.i]<<8)|s.b[s.i+1]; s.i+=2; return v
    def cstr(s):
        j=s.b.index(0,s.i); t=s.b[s.i:j].decode('latin1'); s.i=j+1; return t
    def index(s):
        t=s.u8()
        if t==0x02:
            v=s.u16()
            if v&0xC000==0xC000 or v&0xC000==0x4000: return 'AR[%d]'%(v&0x3fff)
            return 'R[%d]'%(v&0x7fff) if v&0x8000 else str(v)
        if t in REG: return '%s[%s]'%(REG[t],s.index())
        if t==0x01: return s.const()
        return '<idx%02x>'%t
    def const(s):
        sz=s.u8()
        if sz==1:
            v=s.u8(); return str(v-256 if v>127 else v)
        if sz==2:
            v=struct.unpack('>i',s.b[s.i:s.i+4])[0]; s.i+=4; return str(v)
        if sz==3:
            v=struct.unpack('>f',s.b[s.i:s.i+4])[0]; s.i+=4; return ('%g'%v)
        return '<c%02x>'%sz
    def _adv(s,n): s.i+=n; return False
    def operand(s):
        t=s.u8()
        if t==0x01: return s.const()
        if t==0x04:
            a=s.index()
            cm=(':'+COM['PR'][int(a)]) if a.isdigit() and int(a) in COM['PR'] else ''
            if s.peek()==0x02:
                e=s.index(); return 'PR[%s,%s%s]'%(a,e,cm)
            return 'PR[%s%s]'%(a,cm)
        if t in REG:
            n=REG[t]; ix=s.index()
            if n=='P' and ix.isdigit() and int(ix) in PCOM: return 'P[%s:%s]'%(ix,PCOM[int(ix)])
            if n in COM and ix.isdigit() and int(ix) in COM[n]: return '%s[%s:%s]'%(n,ix,COM[n][int(ix)])
            return '%s[%s]'%(n,ix)
        if t==0x32:
            v=s.u8(); return {0:'OFF',1:'ON',7:'LPOS',8:'JPOS'}.get(v,'KW%d'%v)
        if t==0x7d: return ' TIMEOUT,'
        if t==0x75: return '!'
        if t==0x33: return 'PULSE,%.1fsec'%(s.u8()/10)
        if t==0x1a: return s.cstr()
        if t==0x82:
            n=s.cstr(); return n
        if t in OPS: return OPS[t]
        return '<%02x>'%t
    def expr(s,stop=()):
        out=[]
        while s.more() and s.peek() not in stop:
            out.append(s.operand())
        return ''.join(out)

def dec_line(b):
    p=P(b); op=p.u8()
    try:
        if op==0xff: return ''
        if op==0x48: return '//'+dec_line(b[1:])
        if op==0x34: return 'COL DETECT OFF'
        if op==0x35: return 'COL DETECT ON'
        if op==0x95: return 'PAYLOAD[%d]'%b[-1]
        if op==0x49 and b[1]==0x07: return 'ENDIF'
        if op==0x49 and b[1]==0x06: return 'ELSE'
        if op==0x49:
            p.i=2; e=[]
            while p.more() and not (p.peek()==0x49): e.append(p.operand())
            return 'IF '+''.join(e)+' THEN'
        if op==0x1e: return '! '+p.cstr()
        if op==0x1f: return 'MESSAGE[%s]'%p.cstr()
        if op==0x80:
            n=p.index(); t=p.cstr(); return 'LBL[%s%s]'%(n,':'+t if t else '')
        if op==0x7e: return 'JMP '+p.expr()
        if op==0x85: return 'END'
        if op==0x84: return 'ABORT'
        if op==0x81:
            p.u8(); n=p.cstr(); rest=b[p.i:]
            if rest: return 'CALL %s(%s)'%(n,args(rest))
            return 'CALL '+n
        if op==0x18: return 'OVERRIDE'+p.expr()
        if op==0x20: return 'UFRAME_NUM'+p.expr()
        if op==0x22: return 'UTOOL_NUM'+p.expr()
        if op==0x21: n=p.index(); return 'UFRAME[%s]'%n+p.expr()
        if op==0x23: n=p.index(); return 'UTOOL[%s]'%n+p.expr()
        if op in (0x78,0x79,0x6b,0x7c,0x7a):
            kw={0x78:'IF ',0x79:'SELECT ',0x6b:'       =',0x7c:'WAIT ',0x7a:'       ELSE'}[op]
            return kw+tail(p)
        if op==0x7b:
            v=p.index()
            return 'WAIT %.2f(sec)'%(int(v)/100) if v.isdigit() else 'WAIT %s'%v
        if op==0xcb: return 'SKIP CONDITION '+p.expr()
        if op==0xfe: return motion(p)
        p.i=0
        return p.expr()
    except Exception as e:
        return '?? '+b.hex(' ')
def tail(p):
    out=[]
    while p.more():
        t=p.peek()
        if t==0x7e: p.u8(); out.append(', JMP '+p.operand())
        elif t==0x81:
            p.u8(); p.u8(); n=p.cstr(); out.append(', CALL '+n)
        elif t==0x7f: out.append(p.operand())
        else: out.append(p.operand())
    return ''.join(out)
def args(b):
    p=P(b); out=[]
    if p.u8()!=0x3d: return b.hex(' ')
    n=p.u8()
    while p.more() and p.peek()!=0x40:
        t=p.peek()
        if t==0x3f: p.u8(); out.append("'%s'"%p.cstr())
        else: out.append(p.operand())
    return ','.join(out)
UNITS={0:'%',1:'mm/sec',7:'mm/sec',2:'cm/min',4:'deg/sec',5:'sec',6:'msec'}
def motion(p):
    b=p.b
    typ={1:'J',2:'L',3:'C',4:'A'}.get(b[1],'?%d'%b[1])
    pt=b[2]; idx=(b[3]<<8)|b[4]
    if pt==0: pos='P[%d%s]'%(idx,':'+PCOM[idx] if idx in PCOM else '')
    elif pt==1 and idx&0x4000: pos='PR[AR[%d]]'%(idx&0x3fff)
    elif pt==1 and idx&0x8000: pos='PR[R[%d]]'%(idx&0x7fff)
    elif pt==1: pos='PR[%d%s]'%(idx,':'+COM['PR'][idx] if idx in COM['PR'] else '')
    elif pt==2: pos='PR[R[%d]]'%idx
    else: pos='?%d[%d]'%(pt,idx)
    sp=(b[5]<<8)|b[6]; u=b[7]
    if u&0x40: sps='R[%d]'%sp; u&=~0x40
    else: sps=str(sp)
    sps+=UNITS.get(u,'u%d'%u)
    term='FINE' if b[8]==0 else 'CNT%d'%b[9]
    rest=b[10:]
    o=decopts(rest)
    return '%s %s %s %s%s'%(typ,pos,sps,term,o)
def decopts(rest):
    if not rest: return ''
    p=P(rest); out=[]
    while p.more():
        t=p.u8()
        if t==0xcd: out.append('Offset,'+p.operand())
        elif t==0xca: out.append('Skip,'+p.operand())
        elif t==0xcc:
            l=p.operand(); out.append('Skip,%s,%s'%(l,p.expr()))
        elif t==0xd3: out.append('ACC%d'%p.u16())
        else: out.append('<opz.%02X>'%t)
    return ' '+' '.join(out)

def positions(d):
    p,_=split(d)
    if p is None: return []
    t=d[p:]
    if t[:3]!=b'\xff\xff\x03': return []
    i=3; out=[]
    while i+2<=len(t):
        if t[i:i+2]==b'\xff\xff': break
        n=(t[i]<<8)|t[i+1]; e=t[i+2:i+2+n]; i+=2+n
        idx=(e[0]<<8)|e[1]
        if len(e)<32:
            out.append((idx,0,0,(float('nan'),)*6,'(dati non standard)',e.hex(' '))); continue
        uf=e[7]>>4; ut=e[7]&15
        if e[5] in (0x12,0x02):
            f=struct.unpack('>6f',e[8:32]); cs=36
        else:
            import math
            f=tuple(math.degrees(x) for x in struct.unpack('>6f',e[8:32])); cs=None; uf=-1
        com=''
        if cs is not None:
            j=e.find(b'\0',cs); com=e[cs:j].decode('latin1') if j>cs else ''
        else:
            # find printable tail
            k=len(e)-1
            while k>0 and e[k]==0: k-=1
            st=k
            while st>0 and 32<=e[st-1]<127: st-=1
            com=e[st:k+1].decode('latin1') if k-st>=2 else ''
        out.append((idx,uf,ut,f,com,e[2:8].hex(' ')))
    return out

if __name__=='__main__':
    for fn in sys.argv[1:]:
        d=open(fn,'rb').read()
        _,lines=split(d)
        PCOM.clear()
        for idx,uf,ut,f,com,meta in positions(d):
            if com and 'non standard' not in com: PCOM[idx]=com
        print('/PROG',os.path.basename(fn)[:-3].upper())
        for k,l in enumerate(lines,1):
            print('%4d:  %s ;'%(k,dec_line(l)))
        ps=positions(d)
        if ps: print('/POS')
        for idx,uf,ut,f,com,meta in ps:
            if uf==-1:
                print('P[%d%s]  GIUNTI  J1=%.2f J2=%.2f J3=%.2f J4=%.2f J5=%.2f J6=%.2f'%(idx,':'+com if com else '',*f))
            else:
                print('P[%d%s]  UF:%d UT:%d  X=%.1f Y=%.1f Z=%.1f W=%.1f P=%.1f R=%.1f'%(idx,':'+com if com else '',uf,ut,*f))
