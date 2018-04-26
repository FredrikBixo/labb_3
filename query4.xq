(: $cc = ratios :)
let $cc := (for $c in doc('mondial.xml')//country
let $growthIn50 := math:pow(($c/population_growth/number() div 100) + 1, 50)
let $continent := $c/encompassed/@continent
for $f in $continent
let $percentage := ($c/encompassed/@percentage)[(index-of($continent,$f))]/number()
let $year := max($c/population/@year)
let $population := ($c/population[@year = $year]/number()) * $percentage
let $populationIn50 := $c/population[@year = $year]/number() *  $percentage * $growthIn50
let $ccc := $f
group by $ccc
let $total := sum($population)
let $total2 := sum($populationIn50)
order by $total2 div $total
return  <order id="{$ccc}" ratio="{$total2 div $total}" />)

(: select min max ratio :)
let $mi := min($cc/@ratio)
let $ma := max($cc/@ratio)

return <root>{($cc[@ratio = $ma], $cc[@ratio = $mi])}</root>

