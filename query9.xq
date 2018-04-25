declare function local:recriver($river as xs:string?, $sum as xs:double*)
as xs:double* {
   let $currentR := doc('mondial.xml')//river[@id = $river]
   let $upstreamR := doc('mondial.xml')//river[to/@water = $river and to/@watertype = 'river']
   return if (empty($upstreamR)) then $sum + $currentR/length/number() else
   (
   for $u in $upstreamR
   let $id := $u/@id
   return (local:recriver($id,  $sum  + $currentR/length/number()))
   )
};

let $a := 'river-Amazonas'
let $n := 'river-Nil'
let $r := 'river-Rhein'

return (<root>
  <max_dist>
    <river>river-Amazonas</river>
    <dist>{max(local:recriver($a, 0))}</dist>
  </max_dist>
  <max_dist>
    <river>river-Nil</river>
    <dist>{max(local:recriver($n, 0))}</dist>
  </max_dist>
  <max_dist>
    <river>river-Rhein</river>
    <dist>{max(local:recriver($r, 0))}</dist>
  </max_dist>
</root>)
