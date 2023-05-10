        .data
A:      .word 1
B:      .word 2
C:      .word 2
D:      .word 0


        .code
        ld r1, A(r0)
        ld r2, B(r0)
        ld r3, C(r0)
        dadd r4, r0, r0    ;Resultado
        dsub r5, r1, r2    ;Comparo A y B
        bnez r5, sigo1
        daddi   r4, r4, 1  ;Incremento si son iguales
sigo1:  dsub r5, r2, r3    ;Comparo B y C
        bnez r5, sigo2
        daddi r4, r4, 1    ;Incremento si son iguales
sigo2:  dsub r5, r2, r3    ;Comparo A y C
        bnez r5, fin
        daddi   r4, r4, 1  ;Incremento si son iguales
fin:    sd r4, D(r0)       ;Almaceno el resultado en D
        halt