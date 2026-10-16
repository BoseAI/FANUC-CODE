import sys,glob,os
def split(d):
    i=d.find(b'\xff\xff\x02\x00')
    if i<0: return None,[]
    p=i+4; lines=[]
    while p<len(d):
        n=d[p]
        if n==0xff: break
        lines.append(d[p+1:p+1+n]); p+=1+n
        if p<len(d) and d[p]==0: p+=1
        elif p<len(d) and d[p]==0xff: break
        else:
            lines.append(b'??'+d[p:p+8]); break
    return p,lines
if __name__=='__main__':
    for fn in sys.argv[1:]:
        d=open(fn,'rb').read()
        p,lines=split(d)
        print('#####',os.path.basename(fn),len(lines),'lines; tail:',d[p:p+40].hex(' ') if p else None)
        for k,l in enumerate(lines,1):
            print('%4d: %s | %s'%(k,l.hex(' '),''.join(chr(b) if 32<=b<127 else '.' for b in l)))
