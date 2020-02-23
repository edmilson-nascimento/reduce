# Reduce - count data table #

[![N|Solid](https://wiki.scn.sap.com/wiki/download/attachments/1710/ABAP%20Development.png?version=1&modificationDate=1446673897000&api=v2)](https://www.sap.com/brazil/developer.html)

Implementação para ser utilizada como modelo da sintaxe _REDUCE_.

## Necessidade ##
Somar o total de um campo da tabela interna sem a necessidade de fazer um _loop_ ou com sintaxe menos verbosa para o codigo.

## Tecnologia adotada ##
Sera utilizado uma sintaxa com `reduce` que atraves de um laço `for` ja faz a soma do campo informado.

## Solução ##

```abap

data(soma) =
  reduce i(
    init x = 0
    for line in

*   filter #( tab using key id where id = 'LH ' )
   filter #( tab in filter where id = table_line  )

    next x = x + line-qtd
  ).
  
```
