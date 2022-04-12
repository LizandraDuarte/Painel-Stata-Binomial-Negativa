use "C:\Users\Lizandra\Downloads\Base final com e sem financiamento.dta"
destring lattesid, replace
format %25.0g lattesid
xtset lattesid year, yearly
gen ida2 = ida^2 //gerar idade ao quadrado
drop if year < 2006
tab grdreg, gen(dgrdreg)

**********************Painel para valor anual************************************** 
reg pub valoranual coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7 dgrdreg1 dgrdreg2 dgrdreg3 dgrdreg4
********a area 4 não significante pela estatística t*************

******************************Painel para recebeu ou não******************************* 
reg pub recebeu coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7 dgrdreg1 dgrdreg2 dgrdreg3 dgrdreg4
****por meio da ESTATISTICA T TODOS DERAM SIGNIFICANTES********************

***********************Painel valor corrigido****************************
reg pub valorcorr coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7 dgrdreg1 dgrdreg2 dgrdreg3 dgrdreg4
******************a area 4 não significante pela estatística t********************

*################################################################################

*Regressão efeitos fixos 
xtreg pub valoranual coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7, fe
**********************************************************************

*Rgressão efeitos aleatórios 
xtreg pub valoranual coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7, re
*********************************************************************************

*Testar se é melhor efeitos fixos ou aleatórios por meio do teste de Hausman
qui xtreg pub valoranual coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7, fe
estimates store fe
qui xtreg pub valoranual coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7, re
estimates store re
hausman fe re
**** REJEITA H0, ou seja rejeitamos que o modelo de efeitos aleatório é mais adequado que o efeito fixos*****

*##############################################################################

*****************BINOMIAL NEGATIVA para valor corrigido************************
nbreg pub valorcorr coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7 ida2
*************************************************************************

******************BINOMIAL NEGATIVA para recebeu ou não*********************************
nbreg pub recebeu coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7 ida2
****************************************************************************

**************************BINOMIAL NEGATIVA para valor anual***************************
nbreg pub valoranual coaut de sup genero ida edu area1 area2 area3 area4 area5 area6 area7 ida2 dgrdreg1 dgrdreg2 dgrdreg3 dgrdreg4 ida2
*#####################################################################################

save "D:\DADOS TESE FINAL\saidas primeiras regressões.dta"
file D:\DADOS TESE FINAL\saidas primeiras regressões.dta saved
