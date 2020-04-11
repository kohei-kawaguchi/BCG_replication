cd "/Users/fukui/Dropbox (Personal)/Project/Corona/BCG/main/BCG_replication/"


/*  ------- break line ------- (by the Stata editor for macOS (piu_sign) )  */ 
* Chezch
use RDD_data,clear
gen cases_per = cases/poptotal 
drop if cases_per ==.

keep if country == "Czech Rep."
local cut1 = 2019 - 1953
local cut0 = `cut1' + 18
local cut2 = 2019 - 2010

local russia1 = 2019 - 1981
local russia2 = 2019 - 1994
local maxy = 0.65
twoway (function y = `maxy', range(`cut0' `cut2') recast(area) color(gs14) base(0)) (function y = `maxy', range(`cut1' `cut2') recast(area) color(gs11) base(0)) /*
*/  (scatteri  0 `russia1' `maxy' `russia1',recast(line) lc(navy) lw(0.8)) (scatteri  0 `russia2' `maxy' `russia2',recast(line) lc(navy) lw(0.8)) (scatter cases_per age if age < 90,mcolor(maroon)) /*
*/(line bcg_rate age,yaxis(2) lw(0.5) lc(forest_green)) , xtitle("") ytitle("BCG immunization rate (%)",axis(2))  ylabel(0(20)100, axis(2)) text(0.05  31.5 "Russia strain", place(c) size(2.3) color(navy)) graphregion(color(white)) ytitle(Cases per thousand) title("Czech") /*
*/ legend(order(1 "BCG coverage" 2 "BCG at birth" 5 "Case ratio" 6 "BCG immunization rate (right axis)"))


/*  ------- break line ------- (by the Stata editor for macOS (piu_sign) )  */ 
* Singapore
use RDD_data,clear
gen cases_per = cases/poptotal 
drop if cases_per ==.

keep if country == "Singapore"
local cut1 = 2019 - 1957
local cut2 = `cut1' + 15
local maxy = 0.6
twoway (function y = `maxy', range(0 `cut2') recast(area) color(gs14) base(0) )  (function y = `maxy', range(0 `cut1') recast(area) color(gs11) base(0) )    (scatter cases_per age,mc(maroon)) /*
*/(line bcg_rate age if year >= 1957,lc(forest_green) lw(0.5) yaxis(2))  /*
*/ , ytitle("BCG immunization rate (%)",axis(2)) ylabel(0(20)100,  axis(2)) xtitle("") graphregion(color(white)) ytitle(Cases per thousand) title("Singapore") legend(order(1 "BCG coverage" 2 "BCG at birth" 3 "Case ratio" 4 "BCG immunization rate (righ axis)") )

/*  ------- break line ------- (by the Stata editor for macOS (piu_sign) )  */ 
* Viet Nam
use RDD_data,clear
gen cases_per = cases/poptotal 
drop if cases_per ==.
keep if country == "Vietnam"

local cut = 2019 - 1985
twoway (function y = 0.01, range(0 `cut') recast(area) color(gs11) base(0) ) ( scatter cases_per age) (line bcg_rate age if year >=1983,yaxis(2) lw(0.5) lc(forest_green))  /*
*/ , graphregion(color(white)) ytitle(Cases per thousand) xtitle("")/*
*/ ytitle("BCG immunization rate (%)",axis(2)) title("Vietnam") legend(order(1 "BCG coverage" 2 "Case ratio" 3 "BCG immunization rate (right axis)"))




/*  ------- break line ------- (by the Stata editor for macOS (piu_sign) )  */ 
* Colombia
use RDD_data,clear
gen cases_per = cases/poptotal 
drop if cases_per ==.

keep if country == "Colombia"

local cut0 = 2019 - 1960
local cut1 = 2019 - 1945
local cut2 = 2019 - 1978
local cut2_r = `cut2' + 5
local maxy = 0.08
local arrowy = 0.003
twoway (function y = `maxy', range(`cut1' 0) recast(area) color(gs14) base(0) )  (function y = `maxy', range(`cut0' 0) recast(area) color(gs11) base(0) )  /*
*/( scatteri  0 `cut2'  `maxy' `cut2' , recast(line) lc(navy) lw(0.8)) ( pcarrowi  `arrowy' `cut2'  `arrowy' `cut2_r', mc(navy) lc(navy) mlw(0.8) lw(0.8)) /*
*/  ( scatter cases_per age if age<=90,mcolor(maroon)) (line bcg_rate age,yaxis(2) lw(0.5) lc(forest_green))/*
*/ ,xtitle("") ytitle("BCG immunization rate (%)",axis(2))  ylabel(0(20)100, axis(2)) text( `arrowy' `cut2_r' "Japan strain", place(3) color(navy)) graphregion(color(white)) ytitle(Cases per thousand) title("Colombia") /*
*/ legend(order(1 "BCG coverage"  2 "BCG at birth" 5 "Case ratio" 6 "BCG immunization arte (right axis)") )


/*  ------- break line ------- (by the Stata editor for macOS (piu_sign) )  */ 
* Thailand
use RDD_data,clear
keep if country == "Thailand"

gen cases_per = cases/poptotal 


local cut0 = 2019 - 1977
local cut2 = 2019 - 1987
local cut2_r = `cut2' - 5
local maxy = 0.1
local arrowy = 0.01
local texty = `arrowy' + 0.006
twoway (function y = `maxy', range(`cut0' 0) recast(area) color(gs12) base(0) ) /*
*/( scatteri  0 `cut2'  `maxy' `cut2' , recast(line) lc(navy) lw(0.8)) ( pcarrowi  `arrowy' `cut2'  `arrowy' `cut2_r', mc(navy) lc(navy) mlw(0.8) lw(0.8)) /*
*/  ( scatter cases_per age if age<=90,mcolor(maroon)) (line bcg_rate age,yaxis(2) lw(0.5) lc(forest_green))/*
*/ ,xtitle("") ytitle("BCG immunization rate (%)",axis(2))  xlabel(0(20)90) ylabel(0(20)100, axis(2)) text( `texty' `cut2' "Japan strain", place(w) color(navy) size(4)) graphregion(color(white)) ytitle(Cases per thousand) title("Thailand") /*
*/ legend(order(1 "BCG coverage"   4 "Case ratio" 5 "BCG immunization rate (right axis)") )

