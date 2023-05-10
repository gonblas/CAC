        .data
tabla:  .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num:    .word 7
long:   .word 10
        .code
        ld r1, long(r0)    ;Contador
        ld r2, num(r0)     ;Numero a buscar
        dadd r3, r0, r0    ;Indice
        dadd r10, r0, r0   ;Resultado
loop:   ld r4, tabla(r3)   ;Cargo un valor de la tabla
        beq r4, r2, listo  ;Si es igual al numero a buscar
        daddi r1, r1, -1   ;Decremento el contador
        daddi r3, r3, 8    ;Paso el contador al siguiente valor de la tabla
        bnez r1, loop      ;Si r1 no es 0 sigo
        j fin              ;Si se termino de recorrer la tabla termino
listo:  daddi r10, r0, 1   ;Si el numero se encuentra en la tabla
fin:    halt