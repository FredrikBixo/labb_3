

(:Find cities which have population over 5000000 and return name, longitude and latitude:)
let $cities := for $city in doc("mondial.xml")/mondial/country/city[./population[last()]>5000000]
return <Values>{$city/name[1]}<Long>{data($city/longitude) * math:pi() div 180}</Long><Lat>{data($city/latitude)*math:pi() div 180}</Lat></Values>

  

(:Return the distance between two cities and their names :)  
let $double := 

for $city1 in $cities
for $city2 in $cities[not(.=$city1)]

return 

if (abs(data($city1/long)-data($city2/long))>math:pi())

then <Values>{$city1/name}{$city2/name}<distance>{math:sqrt(math:pow(abs(data($city1/Lat)-data($city2/Lat)),2)+math:pow(2*math:pi() - abs(data($city1/Long)-data($city2/Long)),2))}</distance></Values>

else <Values>{$city1/name}{$city2/name}<distance>{math:sqrt(math:pow(abs(data($city1/Lat)-data($city2/Lat)),2)+math:pow(abs(data($city1/Long)-data($city2/Long)),2))}</distance></Values>

(:Return the distance between three cities and their names :)  
let $tripple := 

for $line1 in $double
for $line2 in $double[not(.=$line1)]
for $line3 in $double[not(.=$line2)]

where $line1/name[1]= $line2/name[1] and $line2/name[2]= $line3/name[1] and $line3/name[2]= $line1/name[2]

return  <Values>{$line1/name[1]}{$line3/name}<distance>{data($line1/distance)+data($line2/distance)+data($line3/distance)}</distance></Values>



(:Return names of the three cities that form the largest triangle between them:)  
return <root>{$tripple[./distance= max($tripple/distance)]}</root>
