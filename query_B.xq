let $international := (let $x := doc("mondial.xml")//organization
for $c in $x
where starts-with($c/name, 'International')
return $c)

for $c in $international
let $d := doc("mondial.xml")//city[$c/@headq = ./@id]/@country
let $continent := doc("mondial.xml")//country[$d = ./@car_code]/encompassed
where $continent/@continent = 'europe'
return $c/name
