declare namespace functx = "http://www.functx.com";
declare function functx:add-attributes
  ( $elements as element()* ,
    $attrNames as xs:QName* ,
    $attrValues as xs:anyAtomicType* )  as element()? {

   for $element in $elements
   return element { node-name($element)}
                  { for $attrName at $seq in $attrNames
                    return if ($element/@*[node-name(.) = $attrName])
                           then ()
                           else attribute {$attrName}
                                          {$attrValues[$seq]},
                    $element/@*,
                    $element/node() }
 } ;

 declare function local:switch ( $elements as element()* )  as element()?  {



  } ;

(: loop through all elements :)
for $c in (doc("songs.xml")/music/element())
(: reverse the attributes to elements :)
let $r := element {node-name($c)} { for $p in $c/@*
return (element {name($p)} {data($p)} )
}

(: create a nodeName for each element :)
let $g := (for $e in $c/element()
return xs:QName(node-name($e))
)
(: return value for each element :)
let $t := (for $e in $c/element()
return data($e)
)

(: add elements as attributes :)
return (if (not(empty($g))) then (
let $d := functx:add-attributes(
    $r, $g, $t)
return $d
    )
   else
   (
 let $d := functx:add-attributes(
       $r, xs:QName('value'), data($c))
return $d
))
