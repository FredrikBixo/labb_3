let $international := (let $x := doc("mondial.xml")//organization
for $c in $x
where starts-with($c/name, 'International')
return $c)

let $inEU := (for $c in $international
let $d := doc("mondial.xml")//city[$c/@headq = ./@id]/@country
let $continent := doc("mondial.xml")//country[$d = ./@car_code]/encompassed
where $continent/@continent = 'europe'
return $c)

return <root> {for $country in doc("mondial.xml")//country
where every $o in $inEU satisfies contains($o/members[./@type = "member"]/@country/string(), $country/@car_code)
return $country/name} </root>
