            .data
TXT:        .asciiz "Ingrese la clave: "
ERROR:      .asciiz "ERROR\n"
ACIERTO:    .asciiz "Bienvenido!!\n"
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
clave:      .asciiz "1g70"
input:      .byte 0


            .code
            daddi $sp, $0, 0x400
            lw $a0, CONTROL($0)
            lw $a1, DATA($0)
            daddi $a2, $0, input
            jal leer_clave

            daddi $a2, $0, input
            daddi $a3, $0, clave
            jal respuesta

            halt


;Recibe CONTROL en $a0
;Recibe DATA en $a1
;Retorna el caracter en $v0
char:       
            daddi $t0, $0, 9
            sd $t0, 0($a0)
            ld $v0, 0($a1)
            jr $ra


;Recibe CONTROL en $a0
;Recibe DATA en $a1
;Recibe direccion de input en $a2
leer_clave: daddi $sp, $sp, -16
            sd $s0, 0($sp)
            sd $ra, 8($sp)
            daddi $t0, $0, TXT
            sd $t0, 0($a1)
            daddi $t0, $0, 4
            sd $t0, 0($a0)

            daddi $s0, $0, 4
loop:       jal char             ;Leer clave ingresada
            sb $v0, 0($a2)
            daddi $a2, $a2, 1
            daddi $s0, $s0, -1
            bnez $s0, loop
            
            ld $s0, 0($sp)
            ld $ra, 8($sp)
            daddi $sp, $sp, 16
            jr $ra

;Recibe CONTROL en $a0
;Recibe DATA en $a1
;Recibe direccion de input en $a2
;Recibe direccion de clave en $a3
respuesta:  daddi $sp, $sp, -32
            sd $ra, 0($sp)
            sd $s0, 8($sp)
            sd $s1, 16($sp)
            sd $s2, 24($sp)

comparar:   daddi $t0, $0, 4
            daddi $s0, $a2, 0
            daddi $s1, $a3, 0

loop2:      lbu $t1, 0($s0)
            lbu $t2, 0($s1)
            bne $t1, $t2, error
            daddi $s0, $s0, 1
            daddi $s1, $s1, 1
            daddi $t0, $t0, -1
            bnez $t0, loop2
            j acierto
            
error:      daddi $t0, $0, ERROR
            sd $t0, 0($a1)
            daddi $t0, $0, 4
            sd $t0, 0($a0)
            dadd $s2, $a2, $0
            jal leer_clave
            dadd $a2, $s2, $0
            j comparar

acierto:    daddi $t0, $0, ACIERTO
            sd $t0, 0($a1)
            daddi $t0, $0, 4
            sd $t0, 0($a0)

fin:        ld $ra, 0($sp)
            ld $s0, 8($sp)
            ld $s1, 16($sp)
            ld $s2, 24($sp)
            daddi $sp, $sp, 32
            
            jr $ra







