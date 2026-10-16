/PROG S07_LABEL
   1:   ;
   2:  ! Verifico da quale ciclo ;
   3:  ! proviene il robot e ;
   4:  ! scelgo la traiettoria ;
   5:  ! di conseguenza ;
   6:  IF R[1:RobotStatus]=1001, JMP LBL[1] ;
   7:   ;
   8:  ! Non vengo da nessuno ;
   9:  ! dei cicli validi ;
  10:  ! Segnalazione allarme ;
  11:  JMP LBL[98] ;
  12:   ;
  13:   ;
  14:  LBL[1] ;
  15:   ;
  16:  UFRAME[5]=PR[187:Frame Inkjet] ;
  17:  UFRAME_NUM=5 ;
  18:  UTOOL_NUM=2 ;
  19:  R[1:RobotStatus]=7 ;
  20:   ;
  21:  DO[79:Out Obstruction Labeller]=OFF ;
  22:  //L P[2:Avv Label Done] 2000mm/sec CNT10 ;
  23:   ;
  24:  L P[1:Label Done] 2000mm/sec CNT1 ;
  25:  R[1:RobotStatus]=107 ;
  26:   ;
  27:  WAIT R[10:RqRobotMission]=107 OR R[20:TEST]=1 ;
  28:   ;
  29:  IF DI[41:SelLabelSpreadingPath]=OFF, JMP LBL[200] ;
  30:  ! Ciclo spalmatura ;
  31:  UFRAME[5]=PR[195:Frame Spalmatore] ;
  32:  UFRAME_NUM=5 ;
  33:  L P[20:Start Spalmatore] 2000mm/sec CNT0 ;
  34:  L P[21:Stop Spalmatore] 1000mm/sec CNT0 ;
  35:  L P[22:Exit Spalmatore] 1000mm/sec CNT10 ;
  36:  LBL[200] ;
  37:   ;
  38:  R[1:RobotStatus]=1007 ;
  39:  DO[79:Out Obstruction Labeller]=ON ;
  40:   ;
  41:  END ;
  42:  LBL[98] ;
  43:  MESSAGE[..................] ;
  44:  MESSAGE[..SEQUENCE ERROR..] ;
  45:  MESSAGE[..Status <> 1001 ..] ;
  46:  CALL ABORT ;
  47:   ;
  48:   ;
  49:  LBL[99] ;
  50:  CALL ABORT ;
  51:   ;
/POS
P[1:Label Done]  UF:5 UT:2  X=-111.0 Y=122.5 Z=132.0 W=-180.0 P=0.0 R=0.0
P[2:Avv Label Done]  UF:5 UT:2  X=-111.0 Y=222.5 Z=132.0 W=-180.0 P=0.0 R=0.0
P[3:Start Spalmatore]  UF:5 UT:2  X=149.5 Y=250.5 Z=322.0 W=-180.0 P=0.0 R=0.0
P[20:Start Spalmatore]  UF:5 UT:2  X=-111.0 Y=122.5 Z=132.0 W=180.0 P=0.0 R=132.0
P[21:Stop Spalmatore]  UF:5 UT:2  X=-111.0 Y=122.5 Z=132.0 W=180.0 P=0.0 R=132.0
P[22:Exit Spalmatore]  UF:5 UT:2  X=-111.0 Y=222.5 Z=132.0 W=180.0 P=0.0 R=132.0
