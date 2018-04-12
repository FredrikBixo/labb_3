for $country in doc("mondial.xml")/mondial/country
let $values := (for $foo in $country/population/@year
return $foo)

let $max := (for $zoo in $country/population
where data($zoo/@year)=data(max($values))
return $zoo)

let $min := (for $zoo in $country/population
where data($zoo/@year)=data(min($values))
return $zoo)

where data($max) div data($min)>10
return <value>{$country/name} <ratio>{format-number(data($max) div data($min),".0")}</ratio></value>