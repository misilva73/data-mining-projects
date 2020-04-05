******************************************;
*** Begin Scoring Code from PROC DMINE ***;
******************************************;

length _WARN_ $ 4;
label _WARN_ = "Warnings";


/*----G_Marital_Status begin----*/
length _NORM8 $ 8;
_NORM8 = put( Marital_Status , $8. );
%DMNORMIP( _NORM8 )
drop _NORM8;
select(_NORM8);
  when('DIVORCED' ) G_Marital_Status = 0;
  when('MARRIED' ) G_Marital_Status = 2;
  when('SINGLE' ) G_Marital_Status = 1;
  when('TOGETHER' ) G_Marital_Status = 2;
  when('WIDOW' ) G_Marital_Status = 1;
  otherwise substr(_WARN_, 2, 1) = 'U'; 
end;
label G_Marital_Status="Grouped Levels for  Marital_Status";
/*----Marital_Status end----*/


****************************************;
*** End Scoring Code from PROC DMINE ***;
****************************************;
