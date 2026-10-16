/PROG CC_SPALM
   1:   ;
   2:  PR[1:Appoggio]=P[100:0_NUT] ;
   3:  PR[1,3:Appoggio]=PR[1,3:Appoggio]+R[126:Dim.Z Prod]-R[510:OffZ1LblSpreader] ;
   4:  PR[1,6:Appoggio]=PR[1,3:Appoggio]+R[146:OffsRLabel1] ;
   5:   ;
   6:  IF R[146:OffsRLabel1]<>0 AND R[146:OffsRLabel1]<>180, JMP LBL[10] ;
   7:  PR[1,1:Appoggio]=R[124:Dim.X Prod]/2 ;
   8:  PR[1,2:Appoggio]=R[125:Dim.Y Prod]/2 ;
   9:   ;
  10:  JMP LBL[1] ;
  11:   ;
  12:  LBL[10:RotLbl 90 O 270] ;
  13:  PR[1,1:Appoggio]=R[125:Dim.Y Prod]/2 ;
  14:  PR[1,2:Appoggio]=R[124:Dim.X Prod]/2 ;
  15:   ;
  16:  LBL[1] ;
  17:  PR[1,1:Appoggio]=R[508:OffXLblSpreader]-PR[1,1:Appoggio] ;
  18:  PR[1,2:Appoggio]=R[509:OffYLblSpreader]+PR[1,2:Appoggio] ;
  19:  ! Punto fine spalm ;
  20:  PR[2:Appoggio]=PR[1:Appoggio] ;
  21:  PR[2,3:Appoggio]=R[126:Dim.Z Prod]-R[511:OffZ2LblSpreader] ;
  22:  ! Punto allontan.spalm ;
  23:  PR[3:Appoggio]=PR[2:Appoggio] ;
  24:  PR[3,2:Appoggio]=PR[3,2:Appoggio]+100 ;
  25:   ;
  26:  CALL PR2P_MUL(1,20,'S07_LABEL',3) ;
  27:   ;
  28:  END ;
  29:  L P[100:0_NUT] 100mm/sec FINE ;
/POS
P[100:0_NUT]  UF:0 UT:1  X=0.0 Y=0.0 Z=0.0 W=180.0 P=0.0 R=0.0
