*SAS Commands for Multiple Regression with Hair Text;




*Running correlations on all metric variables;
proc corr data=sasuser.hbat;
   var recommend prod_qual -- del_speed;
run;
*-------------------------------------------------------;



*Running multiple regression on all metric variables;
*With satis as dependent variable:  Full Model;
proc reg data=sasuser.hbat;
   model recommend = prod_qual -- del_speed /vif;
run;
*--------------------------------------------------------;



*Model Building using variable selection techniques;
*The first model statement uses the stepwise variable selection technique;
*The second model statement produces the best 3 models using the adjusted rsquared and cp variable selection method; 
proc reg data=sasuser.hbat plots (only label) = (adjrsq cp);
   model recommend= prod_qual -- del_speed /selection=stepwise;
   model recommend=prod_qual -- del_speed /selection=adjrsq cp best=3;
run;
*-------------------------------------------------------;



*Running regression on final model; 
*Checking regression assumptions on final model & looking for outliers and influence values;
proc reg data=sasuser.hbat plots(only label)=(CooksD RStudentByLeverage DFFITS DFBETAS);
   model recommend= complaint prod_qual sales_image ecommerce prod_line ordering/vif influence;
run;
*-------------------------------------------------------;


 

*Splitting hbat data sets into two separate data sets; 
*Then running stepwise regression on both data sets;
ods rtf file='N:\Multivariate Data Analysis DSCI 499\Week 4\Multiple regression Block5.rtf';
proc sort data=sasuser.hbat;
   by id;  *sorting data by id so we can split the data file on id;
data one;
   set sasuser.hbat;
   if id le 50;

data two;
   set sasuser.hbat;
   if id gt 50;

proc reg data=one;
    model recommend = prod_qual -- del_speed / selection=stepwise;

proc reg data=two;
    model recommend= prod_qual -- del_speed / selection=stepwise;

run;

ods rtf close;
