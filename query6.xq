(:Find cities which  have at least 100,000 inhabitants :)
let $QualifiedCities := doc("mondial.xml")/mondial/country/city[./population[last()]>=100000]

(:Find Airports which are elevated above 500 m:)
let $QualifiedAirport := doc("mondial.xml")/mondial//airport[./elevation>500]

(:Pair city with airport:)
for $Airports in $QualifiedAirport
for $Cities in $QualifiedCities

where $Airports/@city = $Cities/@id

return <Values>{data($Cities/name)},{data($Airports/name)}</Values>
