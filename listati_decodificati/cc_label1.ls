/PROG CC_LABEL1
   1:   ;
   2:  PR[1:Appoggio]=P[100:0_NUT] ;
   3:  PR[1,3:Appoggio]=R[126:Dim.Z Prod]-R[129:OffsZLabel1] ;
   4:  PR[1,4:Appoggio]=-180 ;
   5:  PR[1,6:Appoggio]=R[146:OffsRLabel1] ;
   6:   ;
   7:  IF R[146:OffsRLabel1]<>0 AND R[146:OffsRLabel1]<>180, JMP LBL[10] ;
   8:  PR[1,1:Appoggio]=R[124:Dim.X Prod]/2 ;
   9:  PR[1,2:Appoggio]=R[125:Dim.Y Prod]/2 ;
  10:   ;
  11:  JMP LBL[1] ;
  12:   ;
  13:  LBL[10:RotLbl 90 O 270] ;
  14:  PR[1,1:Appoggio]=R[125:Dim.Y Prod]/2 ;
  15:  PR[1,2:Appoggio]=R[124:Dim.X Prod]/2 ;
  16:   ;
  17:  LBL[1] ;
  18:  PR[1,1:Appoggio]=R[127:OffsXLabel1]-PR[1,1:Appoggio] ;
  19:  PR[1,2:Appoggio]=R[128:OffsYLabel1]+PR[1,2:Appoggio] ;
  20:   ;
  21:  PR[2:Appoggio]=PR[1:Appoggio] ;
  22:  PR[2,2:Appoggio]=PR[2,2:Appoggio]+100 ;
  23:   ;
  24:  CALL PR2P_MUL(1,1,'S07_LABEL',2) ;
  25:   ;
  26:  END ;
  27:  L P[100:0_NUT] 100mm/sec FINE ;
/POS
P[100:0_NUT]  UF:0 UT:1  X=0.0 Y=0.0 Z=0.0 W=180.0 P=0.0 R=0.0
