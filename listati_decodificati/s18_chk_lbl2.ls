/PROG S18_CHK_LBL2
   1:  UFRAME[5]=PR[179:LayerB Prod60] ;
   2:  UFRAME_NUM=5 ;
   3:  UTOOL[2]=PR[182:Tool A+B] ;
   4:  UTOOL_NUM=2 ;
   5:   ;
   6:  ! Verifico da quale ciclo ;
   7:  ! proviene il robot e ;
   8:  ! scelgo la traiettoria ;
   9:  ! di conseguenza ;
  10:  IF R[1:RobotStatus]=1017, JMP LBL[1] ;
  11:   ;
  12:  ! Non vengo da nessuno ;
  13:  ! dei cicli validi ;
  14:  ! Segnalazione allarme ;
  15:  JMP LBL[98] ;
  16:   ;
  17:  LBL[1] ;
  18:  R[1:RobotStatus]=18 ;
  19:  PR[9:Appoggio]=P[1:Pos1 Label Check] ;
  20:  CALL ALIGNROT ;
  21:  DO[80:Out Obstruction ChkLabel]=OFF ;
  22:   ;
  23:  L P[1:Pos1 Label Check] 2000mm/sec CNT5 ;
  24:  R[1:RobotStatus]=118 ;
  25:  L P[2:Pos2 Label Check] 1000mm/sec CNT1 ;
  26:   ;
  27:  WAIT R[10:RqRobotMission]=118 OR R[20:TEST]=1 ;
  28:  L P[3:Exit Label Check] 2000mm/sec CNT10 ;
  29:  R[1:RobotStatus]=1018 ;
  30:  DO[80:Out Obstruction ChkLabel]=ON ;
  31:  END ;
  32:  LBL[98] ;
  33:  MESSAGE[..................] ;
  34:  MESSAGE[..SEQUENCE ERROR..] ;
  35:  MESSAGE[..S18_CHK_LBL2..] ;
  36:  MESSAGE[..Status <> 1017 ..] ;
  37:  MESSAGE[..................] ;
  38:  CALL ABORT ;
  39:   ;
  40:   ;
  41:  LBL[99] ;
  42:  CALL ABORT ;
  43:   ;
/POS
P[1:Pos1 Label Check]  UF:5 UT:2  X=-142.5 Y=242.5 Z=242.0 W=-180.0 P=0.0 R=-90.0
P[2:Pos2 Label Check]  UF:5 UT:2  X=-142.5 Y=242.5 Z=242.0 W=-180.0 P=0.0 R=-90.0
P[3:Exit Label Check]  UF:5 UT:2  X=-142.5 Y=342.5 Z=242.0 W=-180.0 P=0.0 R=-90.0
