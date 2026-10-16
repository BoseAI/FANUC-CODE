/PROG CHK_BUF
   1:  ! Aggiusto le uscite di ;
   2:  ! buffer pieno e vuoto ;
   3:  R[95:Appoggio]=R[59:NumProdBuffer]+1 ;
   4:  R[95:Appoggio]=R[95:Appoggio]*R[125:Dim.Y Prod] ;
   5:  IF R[95:Appoggio]>=R[151:DimensioneBuffer], JMP LBL[2] ;
   6:  DO[61:Buffer Pieno]=OFF ;
   7:  JMP LBL[3] ;
   8:  LBL[2] ;
   9:  DO[61:Buffer Pieno]=ON ;
  10:  LBL[3] ;
  11:  IF R[59:NumProdBuffer]<=0, JMP LBL[4] ;
  12:  DO[60:Buffer Vuoto]=OFF ;
  13:  JMP LBL[5] ;
  14:  LBL[4] ;
  15:  DO[60:Buffer Vuoto]=ON ;
  16:  R[59:NumProdBuffer]=0 ;
  17:  LBL[5] ;
  18:  END ;
