        .data
cant:   .word 8
datos:  .word 1, 2, 3, 4, 5, 6, 7, 8
res:    .word 0
        .code
        dadd r1, r0, r0    ;r1: Indice
        ld r2, cant(r0)    ;r2: Contador
loop:   ld r3, datos(r1)   ;Carga un elemento de la tabla
        daddi r2, r2, -1   ;Decrementa el contador
        dsll r3, r3, 1     ;Multiplica por 2 (rota a izq.)
        sd r3, res(r1)     ;Carga el elemento multiplicado como elemento de res
        daddi r1, r1, 8    ;Incremento el indice
        bnez r2, loop      ;Salto a loop si r2 no es 0
        nop                ;Instr. para delay-slop
        halt