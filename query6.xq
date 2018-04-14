(:Find cities which  have at least 100,000 inhabitants :)
let $QualifiedCities := 

for $city in doc("mondial.xml")/mondial/country/city
let $values := (for $foo in $city/population/@year return $foo)


for $zoo in $city/population

where data($zoo//@year)=data(max($values)) and data($zoo)>=100000
return $city

(:Find Airports which are elevated above 500 m:)
let $QualifiedAirport := doc("mondial.xml")/mondial//airport[./elevation>500]

(:Pair city with airport:)
for $Airports in $QualifiedAirport
for $Cities in $QualifiedCities

where $Airports/@city = $Cities/@id

return <Values>{data($Cities/name)},{data($Airports/name)}</Values>