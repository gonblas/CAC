        .data
TABLA:  .word 1, 5, 9, 13, 65, 23
X:      .byte 9
CANT:   .byte 0
RES:    .byte 0

.code
        dadd r1, r0, r0     ;Indice
        lb r2, X(r0)        
        dadd r3, r0, r0     ;CANT
        daddi r10, r0, X

loop:   lb r5, TABLA(r1)
        daddi r10, r10, -8  ;Decremento iteraciones
        slt r6, r2, r5 
        sd r6, RES(r1)      ;Mando 0 a resultado si es menor a igual
        dadd r3, r3, r6     ;Incremento CANT
        daddi r1, r1, 8     ;Aumento el indice
        bnez r10, loop

fin:    sb r3, CANT(r0)
        halt