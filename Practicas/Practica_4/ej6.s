        .data
A:      .byte 1
B:      .byte 2
C:      .byte 2
D:      .byte 0

        .code
        lb r1, A(r0)
        lb r2, B(r0)
        lb r3, C(r0)
        daddi r6, r0, 2
        dadd r4, r0, r0    ;Resultado
        dsub r5, r1, r2    ;Comparo A y B
        bnez r5, sigo1
        dadd r4, r4, r6    ;Incremento si son iguales
        daddi r6, r6, -1
sigo1:  dsub r5, r2, r3    ;Comparo B y C
        bnez r5, sigo2
        dadd r4, r4, r6    ;Incremento si son iguales
        daddi r6, r6, -1
sigo2:  dsub r5, r1, r3    ;Comparo A y C
        bnez r5, fin
        dadd r4, r4, r6    ;Incremento si son iguales
fin:    sb r4, D(r0)       ;Almaceno el resultado en D
        halt