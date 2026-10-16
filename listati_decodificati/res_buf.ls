/PROG RES_BUF
   1:  R[59:NumProdBuffer]=0 ;
   2:  CALL CHK_BUF ;
   3:  LBL[1] ;
   4:  DO[76:BufferResettato]=PULSE,0.2sec ;
   5:  IF DI[76:Reset Buffer]=ON, JMP LBL[1] ;
   6:   ;
   7:   ;
