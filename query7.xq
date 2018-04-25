<root>{for $country in doc("mondial.xml")/mondial/country

let $latest:= $country/population[last()]

let $earliest := $country/population[1]

where data($latest) div data($earliest)>10
return <value>{$country/name}<ratio>{format-number(data($latest) div data($earliest),".0")}</ratio></value>}</root>
