import struct,sys
d=open(sys.argv[1],'rb').read()
base=0x39
for i in range(999):
    r=d[base+i*28:base+(i+1)*28]
    if len(r)<28: break
    c=r[:17].split(b'\0')[0].decode('latin1')
    t=r[17]
    v=struct.unpack('>f',r[20:24])[0] if t==3 else struct.unpack('>i',r[20:24])[0]
    if c or v:
        print('R[%d]\t%s\t%s%s'%(i+1,c,round(v,3) if t==3 else v,'' if t in(1,3) else ' type%d'%t))
