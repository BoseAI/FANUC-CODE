import struct,sys
d=open(sys.argv[1],'rb').read()
base=0x3d
for i in range(200):
    r=d[base+i*92:base+(i+1)*92]
    if len(r)<92: break
    c=r[:17].split(b'\0')[0].decode('latin1')
    f=struct.unpack('>9f',r[28:64])
    meta=r[17:28].hex(' ')
    if c or any(abs(x)>1e-6 for x in f):
        print('PR[%d]\t%-17s\t%s\t%s'%(i+1,c,' '.join('%.1f'%x for x in f[:6]),meta))
