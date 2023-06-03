                .data
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
TXT:            .asciiz "Ingrese la base (FP): "
TXT2:           .asciiz "Ingrese el exponente sin signo (Int): "


                .code

                lwu $s0, CONTROL($0)
                lwu $s1, DATA($0)
                daddi $t0, $0, TXT    ;Imprimo TXT
                sd $t0, 0($s1)
                daddi $t0, $0, 4
                sd $t0, 0($s0)

                daddi $t0, $0, 8       ;Leer numero FP
                sd $t0, 0($s0)
                l.d f1, 0($s1)         ;f1 -> base

                daddi $t0, $0, TXT2    ;Imprimo TXT2
                sd $t0, 0($s1)
                daddi $t0, $0, 4
                sd $t0, 0($s0)

                daddi $t0, $0, 8       ;Leer numero Int
                sd $t0, 0($s0)
                ld $a2, 0($s1)         ;a2 -> exponente


                jal a_la_potencia      ;f2 -> resultado

                s.d f2, 0($s1)         
                daddi $t0, $0, 3       ;Imprimir numero FP
                sd $t0, 0($s0)

                halt


;Recibe CONTROL en $a0
;Recibe DATA en $a1
;Recibe el exponente en $a2
;Recibe la base en f1
;Retorna en f2 el resultado (FP)
a_la_potencia:  beqz $a2, pot_cero

                mov.d f2, f1
                daddi $t0, $a2, -1
loop:           mul.d f2, f2, f1
                daddi $t0, $t0, -1
                bnez $t0, loop
                j fin

pot_cero:       daddi $t0, $0, 1
                mtc1 $t0, f2
                cvt.d.l f2, f2

fin:            jr $ra