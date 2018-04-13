let $Start := doc("mondial.xml")/mondial

(: Get all continents :)  
let $continents := distinct-values(for $continent in $Start/country/encompassed/@continent return $continent)

for $continent in $continents


return ($continent, sum(

(: Get all countries :)
for $country in $Start/country

(: Get all islands which has the attribute called lake :)
for $island in $Start/island[@lake]


where $island/@country=$country/@car_code and $country/encompassed[@continent = $continent]

(:Find area of the lake that contains the island and multiply it with the percentage of how much of the country's land is in a certain continent:)
return data($Start/lake[@id=$island/@lake]/area) * data($country/encompassed[@continent = $continent]/@percentage) div 100)

)
