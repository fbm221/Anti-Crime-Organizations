capture log close
log using "C:\Users\fbm221\Desktop\Mardhani.log", text replace

/*     Project:          Anti-Crime Organizations   
       Author:           Faria Mardhani
       Date:             November 6th, 2014
*/

clear
use "C:\Users\fbm221\Desktop\Nbjgf4j.dta"

* Keep only "I" observations
keep if strpos(nteefina , "I")!=0 

* Sort "I" observations by rule date
sort nteefina ruledate

* Reorder variables
order name nteefina ruledate

/* Keep relevant organizations (organized by nteefina)
Notes:
121: Youth Development Programs/Preventing Youth Delinquency. Use in data?
151: Meditation/Conflict Resolution. Use in data? */

keep if nteefina=="I0170" | nteefina=="I0320" | nteefina=="I20" | nteefina=="I70" | nteefina=="I99"
 
* Drop irrelevant I70 observations (organizations in I70 dedicated to domestic violence)
drop if nteefina=="I70" & strpos(name , "ABUSE")!=0  
drop if nteefina=="I70" & strpos(name , "FAMILY")!=0
drop if nteefina=="I70" & strpos(name , "WOMEN")!=0
drop if nteefina=="I70" & strpos(name , "CHILD")!=0
drop if nteefina=="I70" & strpos(name , "DOMESTIC")!=0

* Keep relevant I99 observations
keep if nteefina=="I99" & strpos(name, "CRIME") | strpos(name, "PREVENTION") | strpos(name, "VIOLENCE") | strpos(name, "AGAINST")

* Drop remaining "abuse" observations
drop if strpos(name, "ABUSE")

* Destring ruledate
destring ruledate, gen(rule)

* Reorder variables
order name nteefina rule ruledate

* Generate dummy variable to use ruledate as integer
gen ruleyear=int(rule/100)

*Reorder variables
order name nteefina ruleyear rule ruledate

* Graph Number of Anti-Crime Organizations by Rule Date
hist ruleyear, width(1) freq addlabels

log close
