import module namespace functx = 'http://www.functx.com';

declare function local:dfs($stack, $seen) {

  if(empty($stack)) then $seen
  else (
    let $country := $stack[1]
    let $allCountry :=doc('mondial.xml')//country
    let $currentCrossingNumber := data($country/@crossingNumber)
     
    
      let $updatedSeen :=
        for $code in $seen
        return if ($code/@car_code = $country/border/@country and $code/@crossingNumber > $currentCrossingNumber+1)
        then functx:update-attributes($code,xs:QName('crossingNumber'),$currentCrossingNumber+1)
        else  $code
  
    
    
    let $neighbors :=
        for $code in $country/border/@country[not(. = $seen/@car_code)]
        return  $allCountry[@car_code = $code]
    
    let $taggedNeighbors := local:tag($neighbors,$currentCrossingNumber+1)
    
    
    
    return local:dfs(($stack[position() > 1],$taggedNeighbors), ($updatedSeen, $taggedNeighbors))
  )
};

declare function local:tag($stuff,$currentCrossing) {
  for $onestuff in $stuff
      return functx:add-attributes($onestuff,xs:QName('crossingNumber'),$currentCrossing)
};


let $StartCountry := local:tag(doc('mondial.xml')//country[@car_code = 'S'],0)

return <root>{for $a in local:dfs($StartCountry,$StartCountry)

return <Value crossingNumber="{$a/@crossingNumber}">{$a/name} </Value>}</root>
