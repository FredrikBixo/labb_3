let $europecity := (for $country in doc("mondial.xml")/mondial/country
for $stuff in  $country/encompassed
where $stuff/@continent = "europe" return $country//city/@id)

let $europecountry:= (for $country in doc("mondial.xml")/mondial/country
for $stuff in  $country/encompassed
where $stuff/@continent = "europe" return $country/@car_code)

let $organisation := (for $city in $europecity
for $org in doc("mondial.xml")/mondial/organization
where matches(data($org/name),"International") and $org/@headq = string($city)
return $org)

let $data := for $foo in $organisation
let $test := (for $zoo in $europecountry
where matches($foo/members[1]/@country,$zoo)
return 1)
return <data><number>{sum($test)}</number>{$foo/name}</data>

let $max := max(data($data/number))

for $doo in $data where data($doo/number) = data($max) return $doo/name