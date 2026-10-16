/PROG MANUT_P
   1:   ;
   2:  OVERRIDE=R[153:V_Homing] ;
   3:  UFRAME_NUM=9 ;
   4:  UTOOL[2]=PR[182:Tool A+B] ;
   5:  UTOOL_NUM=2 ;
   6:   ;
   7:  IF DI[32:Rq HeadChanging]=OFF, JMP LBL[1] ;
   8:  J P[101:Head changing] 50% FINE ;
   9:  JMP LBL[2] ;
  10:  LBL[1] ;
  11:  L P[102:Maint Pos] 2000mm/sec FINE ;
  12:  LBL[2] ;
  13:   ;
  14:  WAIT 1.00(sec) ;
  15:  ! CALL CUPS_DW ;
  16:   ;
  17:  ! ATTENZIONE ;
  18:  ! P[101]   memorizzato anche ;
  19:  ! come REFPOS 2 ;
  20:  PR[51:Delta Mov]=JPOS ;
  21:  R[98:Appoggio]=PR[51,1:Delta Mov]/57.296 ;
  22:  $REFPOS1[2].$PERCHPOS[1]=R[98:Appoggio] ;
  23:  R[98:Appoggio]=PR[51,2:Delta Mov]/57.296 ;
  24:  $REFPOS1[2].$PERCHPOS[2]=R[98:Appoggio] ;
  25:  R[98:Appoggio]=PR[51,3:Delta Mov]/57.296 ;
  26:  $REFPOS1[2].$PERCHPOS[3]=R[98:Appoggio] ;
  27:  R[98:Appoggio]=PR[51,4:Delta Mov]/57.296 ;
  28:  $REFPOS1[2].$PERCHPOS[4]=R[98:Appoggio] ;
  29:  R[98:Appoggio]=PR[51,5:Delta Mov]/57.296 ;
  30:  $REFPOS1[2].$PERCHPOS[5]=R[98:Appoggio] ;
  31:  R[98:Appoggio]=PR[51,6:Delta Mov]/57.296 ;
  32:  $REFPOS1[2].$PERCHPOS[6]=R[98:Appoggio] ;
  33:   ;
  34:  WAIT 0.10(sec) ;
  35:   ;
  36:  ABORT ;
  37:   ;
/POS
P[101:Head changing]  UF:9 UT:2  X=-1450.0 Y=-149.9 Z=-267.2 W=-180.0 P=-0.0 R=179.3
P[102:Maint Pos]  UF:9 UT:2  X=-1246.8 Y=-149.9 Z=-267.2 W=-180.0 P=-0.0 R=179.3
