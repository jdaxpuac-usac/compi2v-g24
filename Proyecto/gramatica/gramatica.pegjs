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
  = "/*" (!"*/" .)* "*/"
  
choice
  = concatenation (nl "/" nl concatenation)*

concatenation
  = pluck (_ pluck)*

pluck
  = "@"? _ label

label
  = (identifier _ ":")? _ expression

expression
  = "$"? _ parsingExpression _ quantifier?

quantifier
  = [?+*]
  / "|" _ (number / identifier) _ "|"
  / "|" _ (number / identifier)? _ ".." _ (number / identifier)? _ "|"
  / "|" _ (number / identifier)? _ "," _ choice _ "|"
  / "|" _ (number / identifier)? _ ".." _ (number / identifier)? _ "," _ choice _ "|"

parsingExpression
  = identifier
  / string "i"?
  / range "i"?
  / group
  / point
  / point_adm
  / assertion

group
  = "(" _ choice _ ")"

string
	= ["] [^"]* ["]
    / ['] [^']* [']
    
range = "[" input_range+ "]"

input_range = [^[\]-] "-" [^[\]-]
			/ [^[\]]+

identifier "identificador"
  = [_a-z]i[_a-z0-9]i*

_ "espacios en blanco"
  = [ \t]*

nl "nueva linea"
  = [ \t\n\r]*

number
  = [0-9]+

point
  = "."

point_adm
  = "!" "."

assertion
  = positive_assertion
  / negative_assertion

positive_assertion
  = "&" _ expression

negative_assertion
  = "!" _ expression 
