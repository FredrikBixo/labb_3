
let $t := distinct-values(
for $s in doc('mondial.xml')//sea/located/@province
return tokenize($s,' ')
)

let $c := count(for $p in doc('mondial.xml')//province
where not($t[$p/@id = .])
return $p/name)

let $k := count(doc('mondial.xml')//province)

return <root>{$c div $k}</root>
