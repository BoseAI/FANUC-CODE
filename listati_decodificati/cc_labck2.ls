/PROG CC_LABCK2
   1:   ;
   2:  PR[1:Appoggio]=P[100:0_NUT] ;
   3:  PR[1,3:Appoggio]=R[126:Dim.Z Prod]-R[517:OffsZLabel2] ;
   4:  PR[1,4:Appoggio]=-180 ;
   5:  PR[1,6:Appoggio]=R[518:OffsRLabel2] ;
   6:   ;
   7:  IF R[518:OffsRLabel2]<>0 AND R[518:OffsRLabel2]<>180, JMP LBL[10] ;
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
  18:  PR[1,1:Appoggio]=R[515:OffsXLabel2]-PR[1,1:Appoggio] ;
  19:  PR[1,2:Appoggio]=R[516:OffsYLabel2]+PR[1,2:Appoggio] ;
  20:   ;
  21:  PR[1,1:Appoggio]=PR[1,1:Appoggio]+R[519:OffXLblChk2] ;
  22:  PR[1,2:Appoggio]=PR[1,2:Appoggio]+R[520:OffYLblChk2] ;
  23:  PR[1,3:Appoggio]=PR[1,3:Appoggio]-R[521:OffZ1LblChk2] ;
  24:   ;
  25:  PR[2:Appoggio]=PR[1:Appoggio] ;
  26:  PR[2,3:Appoggio]=PR[2,3:Appoggio]-R[522:OffZ2LblChk2]+R[521:OffZ1LblChk2] ;
  27:   ;
  28:  PR[3:Appoggio]=PR[2:Appoggio] ;
  29:  PR[3,2:Appoggio]=PR[3,2:Appoggio]+100 ;
  30:  PR[3,3:Appoggio]=PR[3,3:Appoggio]+0 ;
  31:   ;
  32:  CALL PR2P_MUL(1,1,'S18_CHK_LBL2',3) ;
  33:   ;
  34:  END ;
  35:  L P[100:0_NUT] 100mm/sec FINE ;
/POS
P[100:0_NUT]  UF:0 UT:1  X=0.0 Y=0.0 Z=0.0 W=180.0 P=0.0 R=0.0
