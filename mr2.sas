data new; /* creating a new data set -- temporary one (in work library) named new */   
set sasuser.hbat;  /* brings in the hbat data set */   
if customer_type=1 then cust1=1; 
else cust1=0;  /* creating new variable -- cust1 */   
if customer_type=2 then cust2=1; 
else cust2=0;  /* creating new variable -- cust2 */
run;

*Full Model -- Multiple regression with two non-metric (customer_type and region) variables coded properly as dummy variables;
*ods rtf file='n:\Multivariate\Multiple regression2.rtf';
proc 
reg data=new;  /* using new data set -- with new dummy variables */   
model Recommend= prod_qual ecommerce prod_line sales_image ordering cust1 cust2 Firm_size /vif;   /* model statement:  y=xs */   /* vif asks for variance inflation factors */
run;

*block 3;
proc 
reg data=new;  /* using new data set -- with new dummy variables */   
model Recommend= prod_qual ecommerce prod_line sales_image ordering Firm_size /vif;   /* model statement:  y=xs */   /* vif asks for variance inflation factors */
run;

*block 4;
proc 
reg data=new;  /* using new data set -- with new dummy variables */   
model Recommend= prod_qual prod_line sales_image ordering Firm_size /vif;   /* model statement:  y=xs */   /* vif asks for variance inflation factors */
run;
