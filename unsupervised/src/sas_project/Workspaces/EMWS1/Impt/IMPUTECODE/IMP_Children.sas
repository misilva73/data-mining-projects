length IMP_Children 8;
label IMP_Children = 'Imputed Children';
IMP_Children = Children;
if missing(Children) then IMP_Children = 1;
