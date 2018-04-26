
(: return european cities :)
let $europecity := (for $country in doc("mondial.xml")/mondial/country
for $stuff in  $country/encompassed
where $stuff/@continent = "europe" return $country//city/@id)

(: return european countries :)
let $europecountry:= (for $country in doc("mondial.xml")/mondial/country
for $stuff in  $country/encompassed
where $stuff/@continent = "europe" return $country/@car_code)

(: return organizations im Europe that starts with international :)
let $organisation := (for $city in $europecity
for $org in doc("mondial.xml")/mondial/organization
where matches(data($org/name),"International") and $org/@headq = string($city)
return $org)

(: 1 for each match :)
let $data := for $foo in $organisation
let $test := (for $zoo in $europecountry
where matches($foo/members[./@type ="member"]/@country,$zoo)
return 1)
return <data><number>{sum($test)}</number>{$foo/name}</data>

(: select organization with most matches :)
let $max := max(data($data/number))

(: return organizations  :)
return <root>{for $doo in $data where data($doo/number) = data($max) return $doo/name}</root>
