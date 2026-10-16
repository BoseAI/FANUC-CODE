/PROG ABORT
   1:  ! Blocca il programma ;
   2:  ! per tutta una serie di errori ;
   3:   ;
   4:  MESSAGE[Progr. aborted] ;
   5:  DO[20:Software fault robot]=PULSE,1.0sec ;
   6:   ;
   7:  DO[26:StartRSR006Done]=OFF ;
   8:   ;
   9:   ;
  10:   ;
  11:   ;
  12:  ABORT ;
