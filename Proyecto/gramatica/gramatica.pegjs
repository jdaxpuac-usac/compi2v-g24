gramatica
  = regla (saltoLinea regla saltoLinea)*

regla "regla"
  = identificador saltoLinea "=" _ tipoRegla saltoLinea ";"
  
tipoRegla
  = concatenacion (saltoLinea "/" saltoLinea concatenacion)*

concatenacion
  = expresion (_ expresion)*

expresion "expresion"
  = parsingExpression [?+*]?

parsingExpression
  = identificador
  / cadena
  / rango
  / subexpresion

cadena "cadena de texto"
	= ["] [^"]* ["]
    / ['] [^']* [']
    
rango "rango" = "[" contenidoRango+ "]"

subexpresion "sub-expresion" = "(" saltoLinea tipoRegla saltoLinea (saltoLinea tipoRegla saltoLinea)* ")"

contenidoRango "contenido del rango" = inicio:contenido "-" fin:contenido &{

  const Numero = c => /[0-9]+/.test(c);     
  const Letra = c => /[a-zA-Z]/.test(c);    

  const esRangoValido = (inicio, fin) => {
    if (Numero(inicio) && Numero(fin)) {
      return parseInt(inicio, 10) <= parseInt(fin, 10);
    } else if (Letra(inicio) && Letra(fin)) {
      return inicio <= fin;
    } else {
      return false;
    }
  };
  return esRangoValido(inicio, fin);
}
/ [^[\]]+

contenido "contenido" = [a-z]i/[0-9]+

identificador "identificador"
  = [_a-z]i[_a-z0-9]i*

_ "espacios en blanco"
  = [ \t]*

saltoLinea "nueva linea"
  = [ \t\n\r]*