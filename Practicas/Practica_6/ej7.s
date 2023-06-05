.data
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
CERO:       .byte 0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0
UNO:        .byte 0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
DOS:        .byte 0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
TRES:       .byte 0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
CUATRO:     .byte 0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,0,0,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0
CINCO:      .byte 0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,0,0,1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0
SEIS:       .byte 0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,1,1,1,1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
SIETE:      .byte 0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,1,1,0,0,1,1,0,1,1,1,1,1,1,0,0,0,0,0,0,0
OCHO:       .byte  0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0
NUEVE:      .byte 0,0,1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,1,1,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0
BLANCO:     .word32 0x00FFFFFF
NEGRO:      .word32 0x00000000

.code
                lw $s6, CONTROL($0)
                lw $s7, DATA($0)
                daddi $t0, $0, 8         ;Pedir un numero
                
pedir:          sd $t0, 0($s6)           ;Pedir un numero de un digito
                lbu $s2, 0($s7)
                slti $t1, $s2, 9         ;t1 = 1 -> Numero menor o igual a 9
                beqz $t1, pedir
                slti $t1, $s2, -1        ;t1 = 1 -> Numero menor o igual a -1
                bnez $t1, pedir
                
                daddi $s3, $0, CERO      ;Calculo el desplazamiento para moverme al numero correcto
                daddi $t0, $0, 64
                dmulu $t1, $t0, $s2 
                dadd $s3, $s3, $t1      ;Direccion de comienzo
                
                lwu $t0, BLANCO($0)
                lwu $t1, NEGRO($0)

                daddi $s1, $0, 9         ;Contador de filas
        
                daddi   $t7, $0, 5       ;Actualizar pixel
                daddi $s0, $0, 0         ;PosY = 0    

fila:           sb $s0, 4($s7)           ;Guardo PosY
                daddi $s4, $0, 7         ;Contador de columnas
                daddi $s5, $0, 0         ;PosX = 0

                columnas:   sb $s5, 5($s7)           ;Guardo la columna actual
                            lbu $t2, 0($s3)          ;Guardo el flag
                            beqz $t2, no_pinto
                            sw $t1, 0($s7)           ;Imprimo un negro
                            j sigo
                no_pinto:   sw $t0, 0($s7)           ;Imprimo un blanco
                sigo:       sd $t7, 0($s6)           ;Imprimo el pixel
                            daddi $s3, $s3, 1        ;Incremento la direccion
                            daddi $s4, $s4, -1       ;Decremento cant de columnas
                            daddi $s5, $s5, 1        ;PosX += 1
                            bnez $s4, columnas       ;Salto si me quedan columnas
                
                daddi $s0, $s0, 1         ;PosY += 1
                daddi $s1, $s1, -1
                bnez $s1, fila

                halt
