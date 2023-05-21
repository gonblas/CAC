            .data
str1:       .asciiz "Lionel"
str2:       .asciiz "Messi"
pos:        .word 0

            .code
            daddi $sp, $0, 0x400 
            daddi $a0, $0, str1
            daddi $a1, $0, str2
            jal cmp_str
            sd $v0, pos($0)
            halt

;a0: dir. de la primer cadena
;a1: dir. de la segunda cadena
cmp_str:    daddi $sp, $sp, -16
            sd $s1, 0($sp)
            sd $s0, 8($sp)
            daddi $v0, $0, -1   ;Tomo como 0 la pos. inicial
loop:       lbu $s0, 0($a0)     ;Cargo cadenas
            lbu $s1, 0($a1)
            beqz $s0, cmp
            beqz $s1, cmp
            daddi $a0, $a0, 1   ;Me muevo en las cadenas
            daddi $a1, $a1, 1
            daddi $v0, $v0, 1   ;Incremento la posicion
            j loop
cmp:        bne $s0, $s1, fin
            daddi $v0, $0, -1   ;Si las cadenas no difieren
fin:        ld $s1, 0($sp)
            ld $s0, 8($sp)
            daddi $sp, $sp, 16
            jr $ra