        .data
TABLA:  .word 1, 5, 9, 13, 65, 23
LONG:   .word 6
X:      .word 9
CANT:   .word 0
RES:    .word 0

.code
        dadd r1, r0, r0     ;Indice
        ld r2, X(r0)        
        dadd r3, r0, r0     ;CANT
        daddi r4, r0, 1     ;Valor para comparar con slt
        ld r10, LONG(r0)    ;Can. de iteraciones
        dadd r6, r0, r0     ;Inicializo mi flag en 0

loop:   ld r5, TABLA(r1)
        daddi r10, r10, -1  ;Decremento iteraciones
        slt r6, r2, r5      ;r6 = 1 si r2 < r5
        beq r6, r4, inc     ;Si el elemento es mayor
        sd r0, RES(r1)      ;Mando 0 a resultado si es menor a igual
        j sig
inc:    dadd r6, r0, r0     ;Vuelvo el flag a 0
        daddi r3, r3, 1     ;Incremento CANT
        sd r4, RES(r1)      ;Mando 1 a resultado si es mayor

sig:    daddi r1, r1, 8     ;Aumento el indice
        bnez r10, loop

fin:    sd r3, CANT(r0)
        halt