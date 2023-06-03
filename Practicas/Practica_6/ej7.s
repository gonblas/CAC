.data
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
color:          .byte 0, 0, 0, 0

.code
                lw $s0, CONTROL($0)
                lw $s1, DATA($0)

                
                daddi $t0, $0, 9         ;Pedir un caracter
                sd $t0, 0($s0)
                lbu $s2, 0($s1)
                
                



halt
