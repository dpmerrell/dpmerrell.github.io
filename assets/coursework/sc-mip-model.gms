* StarCraft Mixed Integer Program
* David Merrell
* CS524
* Fall 2016
*
* We wish to maximize
*     totalStrength
*         The sum of individual entities' strengths,
*         as given by the metric
*
*         individual strength = (attack damage)*(attack rate)*(hitpoints + range*beta),
*
*         where beta is a parameter encoding the advantage due to range,
*         estimated near 0.5.
*
* The key decision variables are
*     buildEntity(entities,T)
*         The number of each kind of entity to build
*         at each timestep.
*     
* Other auxiliary variables will help us encode the
* resource constraints, build dependencies, etc. 

$title indexes bound
$offsymxref offsymlist offuelxref offuellist offupper

option limrow=10, limcol=0
option optcr=0.001


*** SETS ***

set T "2s timesteps, 5m total" /1*150/;
alias(T, TI);

set entities "(early game) Terran entities"
	/ scv,
	  marine,
	  firebat,
	  vulture,
	  siegeTank,
	  goliath,
	  commandCenter,
	  supplyDepot,
	  barracks,
      refinery,
	  academy,
	  factory,
	  engineeringBay,
	  missileTurret,
	  machineShop,
	  armory
	  /;

alias(entities, I, J)

set buildings(entities) "(early game) Terran buildings"
	/ commandCenter,
	  supplyDepot,
	  barracks,
      refinery
	  academy,
	  factory,
	  engineeringBay,
	  missileTurret,
	  armory
	  /;


* We encode the technological dependencies.
set dependencies(I,J) "Need entity I before entity J";
dependencies('commandCenter','scv') = yes;
dependencies('commandCenter','barracks') = yes;
dependencies('commandCenter','refinery') = yes;
dependencies('commandCenter','supplyDepot') = yes;
dependencies('barracks','marine') = yes;
dependencies('barracks','academy') = yes;
dependencies('academy','firebat') = yes;
dependencies('barracks','factory') = yes;
dependencies('factory','machineShop') = yes;
dependencies('machineShop','siegeTank') = yes;
dependencies('factory','armory') = yes;
dependencies('factory','vulture') = yes;
dependencies('armory','goliath') = yes;

* We encode the production dependencies.
set builder(I,J) "Entity I builds entity J";
builder('commandCenter','scv') = yes;
builder('barracks','marine') = yes;
builder('barracks','firebat') = yes;
builder('factory','vulture') = yes;
builder('factory','siegeTank') = yes;
builder('factory','goliath') = yes;
builder('factory','machineShop') = yes;

* The set of traits
set traits "Traits of various entities"
	/ minerals,
	  gas,
	  supply,
	  buildTime,
	  hitPoints,
	  damageGround,
	  damageAir,
	  rangeGround,
	  rangeAir,
	  cooldownGround,
	  cooldownAir,
	  movementSpeed
	  /;


*** PARAMETERS ***

* A table of entity traits
table entityTraits(entities,traits) "the traits of each entity"
$include sanitized-broodwar-terran.dat
;

display entityTraits;

* Compute a rough entity strength metric
parameter alpha; alpha = 0.5
parameter entityStrength(entities) "A measure of an entity's combat strength";
entityStrength(entities)$(entityTraits(entities,'cooldownGround') ne 0) 
                          = (entityTraits(entities,'damageGround') /
			                 entityTraits(entities,'cooldownGround')) *
			                (entityTraits(entities,'hitPoints') + 
                    (alpha * entityTraits(entities,'rangeGround')));

entityStrength(entities)$(entityTraits(entities,'cooldownGround') eq 0)
                          = 0;
display entityStrength;

* useful constants
parameter mineralLoad;      mineralLoad     = 8.0;
parameter mineralTime;      mineralTime     = 5.3;
parameter mineralTimeInt;   mineralTimeInt  = 5.0;
parameter gasLoad;          gasLoad         = 8.0;
parameter gasTime;          gasTime         = 5.6;
parameter buildTravelTime;  buildTravelTime = 2.0;


* This will be useful for dependency constraints.
parameter bigM(entities)
    / scv 1,
      marine 3,
      firebat 3,
	  vulture 3,
	  siegeTank 3,
	  goliath 3,
	  commandCenter 1,
	  supplyDepot 2,
	  barracks 2,
      refinery 1,
	  academy 1,
	  factory 2,
	  engineeringBay 1,
	  missileTurret 2,
	  machineShop 1,
	  armory 1
	  /;



*** DECISION VARIABLES ***

* This is the most important decision variable:
* What quantity of a given entity do we build at a given timestep?
integer variable buildEntity(T,entities);

* This is the thing we wish to maximize. 
free variable totalStrength



*** AUXILIARY VARIABLES ***

* This is basically a running total of the entities produced. 
integer variable quantityExist(T,entities);

* These are the resources necessary for production.
positive variable minerals(T);
positive variable gas(T);
positive variable supply(T);

* SCVs can be assigned to different tasks--
* resource-gathering or building.
integer variable mineralSCVs(T);  mineralSCVs.lo(T)  = 0;  mineralSCVs.up(T) = 16;
integer variable gasSCVs(T);      gasSCVs.lo(T)      = 0;  gasSCVs.up(T)      = 3;
integer variable buildingSCVs(T); buildingSCVs.lo(T) = 0; 

* This will be useful for discretized mineral-gathering
integer variable beginMining(T);


* initial conditions:
quantityExist.fx('1',entities) = 0;
quantityExist.fx('1','commandCenter') = 1;
quantityExist.fx('1','scv') = 4;
minerals.fx('1') = 50.0;
gas.fx('1') = 0.0;



*** MODEL EQUATIONS ***
equations
objective	                     "We wish to maximize military strength, summed over a period of vulnerability."
updateQuantity(T,entities)       "describes the evolution of entity quantities over time."
techTree(T,I,J)                  "Can't build an entity until its dependencies exist"
scvBalance(T)                    "SCVs can be gathering resources or building structures."
mineralUpdate_Continuous(T)      "Production is dependent on resource-gathering--continuous approximation"
gasUpdate_Continuous(T)          "Production is dependent on resource-gathering--continuous approximation."
buildDependency(T,entities)      "Production of an entity is limited by the number of its builders."
supplyConstraint(T)              "Number of entities constrained by supply depots etc"
constructionLabor(T)             "Construction of buildings requires SCV labor."
gasRefinery(T)                   "A refinery must exist before gas can be gathered."
mineralUpdate_Discrete(T)        "Production is dependent on resource-gathering--discrete trips"
beginMineDef(T)                  "Define this 'beginMining' variable"
;

objective..
totalStrength =E= sum((entities,T)$(ord(T) ge 60), 
                      quantityExist(T,entities) * entityStrength(entities));

updateQuantity(T,entities)$(ord(T) gt 1)..
quantityExist(T,entities) =E= quantityExist(T-1,entities) 
                              + buildEntity(T - entityTraits(entities,'buildTime'), entities);

techTree(T,I,J)$(dependencies(I,J))..
buildEntity(T,J) =L= bigM(J) * quantityExist(T,I);

scvBalance(T)..
quantityExist(T,'scv') =G= mineralSCVs(T) + gasSCVs(T) + buildingSCVs(T);

mineralUpdate_Continuous(T)$(ord(T) gt 1)..
minerals(T) =E= minerals(T-1) + (mineralLoad/mineralTime)*mineralSCVs(T-1)
                              - sum(entities, entityTraits(entities, 'minerals') 
                                              * buildEntity(T-1,entities));

gasUpdate_Continuous(T)$(ord(T) gt 1)..
gas(T) =E= gas(T-1) + (gasLoad/gasTime)*gasSCVs(T-1)
                              - sum(entities, entityTraits(entities, 'gas') 
                                              * buildEntity(T-1,entities));

buildDependency(T,buildings)..
    sum(J$(builder(buildings,J)), 
           quantityExist(T+entityTraits(J,'buildTime'),J)
         - quantityExist(T,J)) 
    =L= quantityExist(T,buildings);


supplyConstraint(T)..
sum(entities$(not(sameas(entities,'supplyDepot') or sameas(entities,'commandCenter'))),
               (quantityExist(T,entities) + 
                buildEntity(T,entities))*entityTraits(entities,'supply'))
    =L= 8.0*quantityExist(T,'supplyDepot') + 10.0*quantityExist(T,'commandCenter');


constructionLabor(T)..
sum(buildings, quantityExist(T+(entityTraits(buildings,'buildTime')+buildTravelTime),buildings)
             - quantityExist(T,buildings))
    =L= buildingSCVs(T);

gasRefinery(T)..
gasSCVs(T) =L= 3.0*quantityExist(T,'refinery');


mineralUpdate_Discrete(T)$(ord(T) gt 1)..
minerals(T) =E= minerals(T-1) + mineralLoad*beginMining(T-mineralTimeInt)
                              - sum(entities, entityTraits(entities, 'minerals') 
                                              * buildEntity(T-1,entities));


beginMineDef(T)..
mineralSCVs(T) =G= sum(TI$((ord(TI) ge ord(T)-mineralTimeInt) and (ord(TI) le ord(T))), 
                         beginMining(TI));



*** MODEL SOLVES ***


*** CONTINUOUS APPROXIMATION OF MINERAL-GATHERING ***
* Preliminary model sweeps some details of resource-gathering
* under the rug. Seems to produce reasonable result, though.
model scmip_conts /objective, updateQuantity, techTree, scvBalance, 
                    mineralUpdate_Continuous, 
                    gasUpdate_Continuous,
                    buildDependency, supplyConstraint,
                    constructionLabor, gasRefinery/; 

scmip_conts.holdfixed = 1;
solve scmip_conts using mip maximizing totalStrength;

* We output the results for analysis.
* CSVs are amenable to the Pandas python package.
file conts_resultfile /conts_resultfile.csv/;
conts_resultfile.nw = 6; conts_resultfile.lw = 3;
put conts_resultfile ;
put 'time,minerals,bldscv,bldmarine,bldsupdep,bldbarracks,scv,marine,supplyDepot,barracks'/;
loop(T, put T.tl ',' minerals.L(T) ',' buildEntity.L(T,'scv') ',' 
           buildEntity.L(T,'marine') ',' buildEntity.L(T,'supplyDepot') ','
           buildEntity.L(T,'barracks') ',' quantityExist.L(T,'scv') ','
           quantityExist.L(T,'marine') ',' quantityExist.L(T,'supplyDepot') ',' 
           quantityExist.L(T,'barracks')/);





*** MORE 'REALISTIC' DISCRETE MINERAL-GATHERING ***
* In actual gameplay, minerals are gathered in discrete trips.
* A worker collects a load of 8 minerals 
* with each trip.
model scmip_discrete /objective, updateQuantity, techTree, scvBalance, 
                      gasUpdate_Continuous,
                      buildDependency, supplyConstraint,
                      constructionLabor, gasRefinery, 
                      mineralUpdate_Discrete, beginMineDef/;
scmip_discrete.holdfixed = 1;
solve scmip_discrete using mip maximizing totalStrength;


* We output the results for analysis.
* CSVs are amenable to the Pandas python package.
file discrete_resultfile / discrete_resultfile.csv/;
discrete_resultfile.nw = 6; discrete_resultfile.lw = 3;
put discrete_resultfile ;
put 'time,minerals,bldscv,bldmarine,bldsupdep,bldbarracks,scv,marine,supplyDepot,barracks'/;
loop(T, put T.tl ',' minerals.L(T) ',' buildEntity.L(T,'scv') ',' 
           buildEntity.L(T,'marine') ',' buildEntity.L(T,'supplyDepot') ','
           buildEntity.L(T,'barracks') ',' quantityExist.L(T,'scv') ','
           quantityExist.L(T,'marine') ',' quantityExist.L(T,'supplyDepot') ',' 
           quantityExist.L(T,'barracks')/);




*** DISCRETE MINERAL GATHERING TIME SENSITIVITY ***
* The duration of mineral gathering trips does not cleanly 
* fit into this model's timestep regime. We rounded down in the
* previous model; in this one, we round up.
mineralTimeInt = 6.0;
model scmip_discrete_longtrip /objective, updateQuantity, techTree, scvBalance, 
                      gasUpdate_Continuous,
                      buildDependency, supplyConstraint,
                      constructionLabor, gasRefinery, 
                      mineralUpdate_Discrete, beginMineDef/;
scmip_discrete_longtrip.holdfixed = 1;
solve scmip_discrete_longtrip using mip maximizing totalStrength;

* We output the results for analysis.
file discrete_resultfile_sensitivity / discrete_resultfile_sensitivity.csv/;
discrete_resultfile_sensitivity.nw = 6; discrete_resultfile_sensitivity.lw = 3;
put discrete_resultfile_sensitivity ;
put 'time,minerals,bldscv,bldmarine,bldsupdep,bldbarracks,scv,marine,supplyDepot,barracks'/;
loop(T, put T.tl ',' minerals.L(T) ',' buildEntity.L(T,'scv') ',' 
           buildEntity.L(T,'marine') ',' buildEntity.L(T,'supplyDepot') ','
           buildEntity.L(T,'barracks') ',' quantityExist.L(T,'scv') ','
           quantityExist.L(T,'marine') ',' quantityExist.L(T,'supplyDepot') ',' 
           quantityExist.L(T,'barracks')/);



*** DISCOUNT SCV COMBAT STRENGTH ***
* Players don't usually think of their workers as
* combat entities. What if the objective function didn't
* depend on the workers?
mineralTimeInt = 5.0;
entityStrength('scv') = 0;
model scmip_discrete_noscv /objective, updateQuantity, techTree, scvBalance, 
                      gasUpdate_Continuous,
                      buildDependency, supplyConstraint,
                      constructionLabor, gasRefinery, 
                      mineralUpdate_Discrete, beginMineDef/;
scmip_discrete_noscv.holdfixed = 1;
solve scmip_discrete_noscv using mip maximizing totalStrength;

* We output the results for analysis.
file discrete_resultfile_noscv / discrete_resultfile_noscv.csv/;
discrete_resultfile_noscv.nw = 6; discrete_resultfile_noscv.lw = 3;
put discrete_resultfile_noscv ;
put 'time,minerals,bldscv,bldmarine,bldsupdep,bldbarracks,scv,marine,supplyDepot,barracks'/;
loop(T, put T.tl ',' minerals.L(T) ',' buildEntity.L(T,'scv') ',' 
           buildEntity.L(T,'marine') ',' buildEntity.L(T,'supplyDepot') ','
           buildEntity.L(T,'barracks') ',' quantityExist.L(T,'scv') ','
           quantityExist.L(T,'marine') ',' quantityExist.L(T,'supplyDepot') ',' 
           quantityExist.L(T,'barracks')/);


*display beginMining.L;
*display quantityExist.L;
*display buildEntity.L;
*display mineralSCVs.L;
*display gasSCVs.L;
*display buildingSCVs.L;
*display minerals.L;
*display gas.L;

