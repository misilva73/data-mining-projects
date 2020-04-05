drop _temp_;
if (P_DepVar1 ge 0.99999030951148) then do;
b_DepVar = 1;
end;
else
if (P_DepVar1 ge 0.96023021739814) then do;
b_DepVar = 2;
end;
else
if (P_DepVar1 ge 0.29742622178888) then do;
b_DepVar = 3;
end;
else
if (P_DepVar1 ge 0.00910903213807) then do;
b_DepVar = 4;
end;
else
if (P_DepVar1 ge 0.00018641340094) then do;
b_DepVar = 5;
end;
else
if (P_DepVar1 ge 5.1445479694983E-6) then do;
b_DepVar = 6;
end;
else
do;
_temp_ = dmran(1234);
b_DepVar = floor(7 + 14*_temp_);
end;
