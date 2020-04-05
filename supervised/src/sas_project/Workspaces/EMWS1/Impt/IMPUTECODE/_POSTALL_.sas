*;
* Drop prediction variables since they are for INPUTS not TARGETS;
* Replace _NODE_ by _XODE_ so it can be safely dropped;
*;
drop
P_Income
P_MntBrandA__Material
P_MntScenario
;
