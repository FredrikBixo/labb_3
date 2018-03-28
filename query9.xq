declare function local:discount($river as xs:string?, $sum as xs:double*)
as xs:double* {
   let $currentR := doc('mondial.xml')//river[@id = $river]
   let $upstreamR := doc('mondial.xml')//river[to/@water = $river and to/@watertype = 'river']
   return if (empty($upstreamR)) then $sum + $currentR/length/number() else
   (
   for $u in $upstreamR
   let $id := $u/@id
   return (local:discount($id,  $sum  + $currentR/length/number()))
   )
};

let $a := 'river-Amazonas'
let $n := 'river-Nil'
let $r := 'river-Rhein'

return (<res>
  <max_dist>
    <river>river-Amazonas</river>
    <dist>{max(local:discount($a, 0))}</dist>
  </max_dist>
  <max_dist>
    <river>river-Nil</river>
    <dist>{max(local:discount($n, 0))}</dist>
  </max_dist>
  <max_dist>
    <river>river-Rhein</river>
    <dist>{max(local:discount($r, 0))}</dist>
  </max_dist>
</res>)
