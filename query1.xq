(: counries who not have an island :)
<root>{for $x in doc('mondial.xml')//country
where not(doc('mondial.xml')//island[$x/@car_code = ./@country])
return $x/name} </root>

