/PROG S08_CHK_LBL
   1:  UFRAME[5]=PR[194:Frame Chk Label] ;
   2:  UFRAME_NUM=5 ;
   3:  UTOOL[2]=PR[182:Tool A+B] ;
   4:  UTOOL_NUM=2 ;
   5:   ;
   6:  ! Verifico da quale ciclo ;
   7:  ! proviene il robot e ;
   8:  ! scelgo la traiettoria ;
   9:  ! di conseguenza ;
  10:  IF R[1:RobotStatus]=1001, JMP LBL[2] ;
  11:  IF R[1:RobotStatus]=1007, JMP LBL[1] ;
  12:  IF R[1:RobotStatus]=1013, JMP LBL[1] ;
  13:   ;
  14:  ! Non vengo da nessuno ;
  15:  ! dei cicli validi ;
  16:  ! Segnalazione allarme ;
  17:  JMP LBL[98] ;
  18:   ;
  19:  LBL[2] ;
  20:  LBL[1] ;
  21:  R[1:RobotStatus]=8 ;
  22:  DO[80:Out Obstruction ChkLabel]=OFF ;
  23:   ;
  24:  L P[1:Pos1 Label Check] 2000mm/sec CNT5 ;
  25:  R[1:RobotStatus]=108 ;
  26:  L P[2:Pos2 Label Check] 1000mm/sec CNT1 ;
  27:   ;
  28:  WAIT R[10:RqRobotMission]=108 OR R[20:TEST]=1 ;
  29:  L P[3:Exit Label Check] 2000mm/sec CNT80 ;
  30:  R[1:RobotStatus]=1008 ;
  31:  DO[80:Out Obstruction ChkLabel]=ON ;
  32:  END ;
  33:  LBL[98] ;
  34:  MESSAGE[..................] ;
  35:  MESSAGE[..SEQUENCE ERROR..] ;
  36:  MESSAGE[..Status <> 1001 ..] ;
  37:  MESSAGE[..Status <> 1007 ..] ;
  38:  MESSAGE[..Status <> 1013 ..] ;
  39:  MESSAGE[..................] ;
  40:  CALL ABORT ;
  41:   ;
  42:   ;
  43:  LBL[99] ;
  44:  CALL ABORT ;
  45:   ;
/POS
P[1:Pos1 Label Check]  UF:5 UT:2  X=-111.0 Y=122.5 Z=132.0 W=-180.0 P=0.0 R=0.0
P[2:Pos2 Label Check]  UF:5 UT:2  X=-111.0 Y=122.5 Z=132.0 W=-180.0 P=0.0 R=0.0
P[3:Exit Label Check]  UF:5 UT:2  X=-111.0 Y=222.5 Z=132.0 W=-180.0 P=0.0 R=0.0
