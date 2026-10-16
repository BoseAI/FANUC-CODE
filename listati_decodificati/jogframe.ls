/PROG JOGFRAME
   1:  ! Choose pickup or ;
   2:  ! deposit frame ;
   3:  CALL MEM_DATI ;
   4:  UFRAME_NUM=8 ;
   5:  UTOOL_NUM=1 ;
   6:  OVERRIDE=R[703:JogSpeed] ;
   7:   ;
   8:  IF R[704:SelJOG Direction]=1013, JMP LBL[1] ;
   9:  IF R[704:SelJOG Direction]=1014, JMP LBL[2] ;
  10:  CALL JOG_MOV ;
  11:  JMP LBL[10] ;
  12:   ;
  13:  LBL[1] ;
  14:  CALL JOG_PICK ;
  15:  JMP LBL[10] ;
  16:   ;
  17:  LBL[2] ;
  18:  CALL JOG_DEP ;
  19:  JMP LBL[10] ;
  20:   ;
  21:  LBL[10] ;
  22:  R[705:JogPos X]=PR[3,1:Appoggio]*10 ;
  23:  R[706:JogPos Y]=PR[3,2:Appoggio]*10 ;
  24:  R[707:JogPos Z]=PR[3,3:Appoggio]*10 ;
  25:  R[708:JogPos W]=PR[3,4:Appoggio]*10 ;
  26:  R[709:JogPos P]=PR[3,5:Appoggio]*10 ;
  27:  R[710:JogPos R]=PR[3,6:Appoggio]*10 ;
  28:  END ;
  29:  J P[100] 100% FINE ;
/POS
P[100]  UF:8 UT:1  X=0.0 Y=0.0 Z=0.0 W=0.0 P=0.0 R=0.0
