/PROG JOG_PICK
   1:  PR[2:Appoggio]=P[100:0 NUT] ;
   2:  PR[2,1:Appoggio]=R[800:X Pickup Bundles] ;
   3:  PR[2,2:Appoggio]=R[801:Y Pickup Bundles] ;
   4:  PR[2,3:Appoggio]=R[802:Z Pickup Bundles] ;
   5:  PR[2,4:Appoggio]=R[803:W Pickup Bundles] ;
   6:  PR[2,5:Appoggio]=R[804:P Pickup Bundles] ;
   7:  PR[2,6:Appoggio]=R[805:R Pickup Bundles] ;
   8:   ;
   9:  SKIP CONDITION DI[514:SB3 JOG PushButton]=OFF ;
  10:  J PR[2:Appoggio] 5% CNT100 Skip,LBL[100],PR[3:Appoggio]=LPOS ;
  11:   ;
  12:  END ;
  13:   ;
  14:  LBL[100:Avv Raggiunto] ;
  15:  DO[28:EnMemorizzaJogPos]=ON ;
  16:  DO[30:Avv Prelievo OK]=PULSE,3.0sec ;
  17:   ;
  18:  WAIT 0.20(sec) ;
  19:  PR[3:Appoggio]=LPOS ;
  20:   ;
  21:   ;
  22:   ;
  23:  END ;
  24:  J P[100:0 NUT] 100% FINE ;
/POS
P[100:0 NUT]  UF:5 UT:2  X=0.0 Y=0.0 Z=0.0 W=0.0 P=0.0 R=0.0
