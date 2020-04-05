*------------------------------------------------------------*;
* Score: Creating Fixed Names;
*------------------------------------------------------------*;
LENGTH EM_EVENTPROBABILITY 8;
LABEL EM_EVENTPROBABILITY = 'Probability for level 1 of DepVar';
EM_EVENTPROBABILITY = P_DepVar1;
LENGTH EM_PROBABILITY 8;
LABEL EM_PROBABILITY = 'Probability of Classification';
EM_PROBABILITY =
max(
P_DepVar1
,
P_DepVar0
);
LENGTH EM_CLASSIFICATION $%dmnorlen;
LABEL EM_CLASSIFICATION = "Prediction for DepVar";
EM_CLASSIFICATION = I_DepVar;
