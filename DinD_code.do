cd "/Users/fukui/Dropbox (Personal)/Project/Corona/BCG/main/BCG_replication/"
use DinD_data,clear

gen case_ratio = cases/poptotal
gen lcase_ratio = log(case_ratio)


gen age_s = (2019- start_y)/10
gen age_e = (2019 - end_y)/10
gen bcg = .
replace bcg = inrange(age_group,age_e,age_s-1)
replace bcg = 1 - (age_e - age_group) if inrange(age_e - age_group,0,1) & bcg == 0
replace bcg = age_s - age_group if inrange(age_s - age_group,0,1) & bcg == 0


gen age_s_g2 = (2019- start_g2)/10
gen age_e_g2 = (2019 - end_g2)/10
gen bcg_g2 = .
replace bcg_g2 = inrange(age_group,age_e_g2,age_s_g2-1) if age_e_g2!=. & age_s_g2!=.
replace bcg_g2 = 1 - (age_e_g2 - age_group) if inrange((age_e_g2 - age_group),0,1) & bcg_g2 == 0
replace bcg_g2 = age_s_g2 - age_group if inrange(age_s_g2 - age_group,0,1) & bcg_g2 == 0
replace bcg_g2 = 0 if bcg_g2 == .

gen bcg_not_g2 = bcg - bcg_g2


reghdfe lcase_ratio bcg [aw = poptotal], a(i.iso3n i.age_group) cluster(iso3n)
reghdfe lcase_ratio bcg [aw = poptotal], a( i.age_group) cluster(iso3n)


reghdfe lcase_ratio, a(i.iso3n i.age_group) residual(lcase_ratio_res)
reghdfe bcg, a(i.iso3n i.age_group) residual(bcg_res)
reghdfe bcg_g2 bcg_not_g2, a(i.iso3n i.age_group) residual(bcg_g2_res2)
reghdfe lcase_ratio bcg_not_g2, a(i.iso3n i.age_group) residual(lcase_res_g2)

tw (scatter lcase_ratio_res bcg_res [w = poptotal], msymbol(circle_hollow) ) (lfit lcase_ratio_res bcg_res [w = poptotal]), graphregion(color(white)) legend(off) ytitle("log cases per thousand (residualized)") xtitle("BCG coverage (residualized)") 


tw (scatter lcase_res_g2 bcg_g2_res2 [w = poptotal] if start_g2 ==., mcolor(gs14) msymbol(circle_hollow) )  /*
*/ (scatter lcase_res_g2 bcg_g2_res2 [w = poptotal] if start_g2 !=., mc(navy) msymbol(circle_hollow) )   /*
*/ (lfit lcase_res_g2 bcg_g2_res2 [w = poptotal],lc(maroon)) , xlabel(-1(0.5)1) graphregion(color(white)) legend(off) /*
*/ ytitle("log cases per thousand (residualized)") xtitle("BCG (JRB) coverage (residualized)") 

