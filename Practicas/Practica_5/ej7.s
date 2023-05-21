            .data
tabla:      .word 1, 20, 155, 6, 9, 17
M:          .word 16
RTA:        .byte 0

            .code
            daddi $a0, $0, tabla
            daddi $a2, r0, M      ;Calculo la cantidad de elementos de la tabla
            dsub $a2, $a2, $a0
            daddi $t0, r0, 8
            ddiv $a2, $a2, $t0

            daddi $sp, $0, 0x400  ;Inicializo la pila
            ld $a1, M($0)
            jal mayor_que
            sd $v0, RTA($0)
            halt
;a0: dir. de tabla
;a1: M
;a2: Cant. de elem.
mayor_que:  daddi $sp, $sp, -8    ;Guardo registro $s0
            sd $s0, 0($sp)
            daddi $v0, $0, 0      ;Inicializo el valor a devolver
loop:       ld $s0, 0($a0)         ;Cargo un valor de la tabla
            slt $t1, $a1, $s0      ;t1=1 si el elemento es mayor que M
            dadd $v0, $v0, $t1    ;Aumento si el elemento es mayor
            daddi $a2, $a2, -1    ;Decremento la cantidad de elementos por procesar
            daddi $a0, $a0, 8     ;Me muevo en la tabla
            bnez $a2, loop        ;Salto si quedan elementos por procesar
            ld $s0, 0($sp)        
            daddi $sp, $sp, 8
            jr $ra
