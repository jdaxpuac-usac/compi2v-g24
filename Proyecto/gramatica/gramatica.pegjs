grammar
  = rule+ nl

rule
  = nl identifier nl string? nl "=" _ choice nl (";")?
  / nl Comment


Comment
  = linecomment (nl linecomment)* 
  / multicomment (nl multicomment)* 

linecomment
  = [/][/] [^\n]*

multicomment
  = "/" (!"/" .)* "*/"
  
choice
  = concatenation (nl "/" nl concatenation)*

concatenation
  = pluck (_ pluck)*

pluck
  = "@"? _ label

label
  = (identifier _ ":")? _ expression