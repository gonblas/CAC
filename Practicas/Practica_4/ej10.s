        .data
cadena: .asciiz "adaddasasfghdas" ; cadena a analizar
car:    .asciiz "d"        ; caracter buscado
cant:   .word 0            ; cantidad de veces que se repite el caracter car en cadena.

        .code
        dadd r1, r0, r0    ;Indice
        dadd r2, r0, r0    ;CANT
        lbu r3, car(r0)

loop:   lbu r4, cadena(r1)
        beq r4, r0, fin
        daddi r1, r1, 1
        bne r4, r3, loop
        daddi r2, r2, 1
        j loop

fin:    sb r2, cant(r0)
        halt

