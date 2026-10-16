/PROG JOG_DEP
   1:  PR[2:Appoggio]=P[100:0 NUT] ;
   2:  PR[2,1:Appoggio]=R[825:X DepositBundle] ;
   3:  PR[2,2:Appoggio]=R[826:Y DepositBundle] ;
   4:  PR[2,3:Appoggio]=R[827:Z DepositBundle] ;
   5:  PR[2,4:Appoggio]=R[828:W DepositBundle] ;
   6:  PR[2,5:Appoggio]=R[829:P DepositBundle] ;
   7:  PR[2,6:Appoggio]=R[830:R DepositBundle] ;
   8:   ;
   9:   ;
  10:  SKIP CONDITION DI[514:SB3 JOG PushButton]=OFF ;
  11:  J P[6:{ING USC MON] 5% CNT100 Skip,LBL[99],PR[3:Appoggio]=LPOS ;
  12:  END ;
  13:  LBL[99] ;
  14:  J PR[2:Appoggio] 5% CNT100 Skip,LBL[100],PR[3:Appoggio]=LPOS ;
  15:   ;
  16:  END ;
  17:   ;
  18:  LBL[100:Avv Raggiunto] ;
  19:  DO[28:EnMemorizzaJogPos]=ON ;
  20:  DO[29:AvvDeposito OK]=PULSE,3.0sec ;
  21:   ;
  22:  WAIT 0.20(sec) ;
  23:  PR[3:Appoggio]=LPOS ;
  24:   ;
  25:   ;
  26:   ;
  27:  END ;
  28:  J P[100:0 NUT] 100% FINE ;
/POS
P[6:{ING USC MON]  GIUNTI  J1=-29.87 J2=-16.88 J3=-31.98 J4=-32.67 J5=-48.69 J6=36.00
P[100:0 NUT]  UF:9 UT:2  X=0.0 Y=0.0 Z=0.0 W=0.0 P=0.0 R=0.0
