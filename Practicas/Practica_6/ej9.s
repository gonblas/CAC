            .data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
color1:     .word32 0x00FF0000   
color2:     .word32 0x00F000F0  
color3:     .word32 0x0000FF00  
color4:     .word32 0x00FFFF00  
color5:     .word32 0x00FF00FF  
color6:     .word32 0x00FF00FF  
color7:     .word32 0x00FF00FF  
color8:     .word32 0x00FF00FF  
pantalla:   .space 2500



.code
            lwu $s6, CONTROL($0)
            lwu $s7, DATA($0)
            daddi $sp, $0, 0x400
            daddi $t0, $0, 9        ;Pedir caracter
            daddi $t1, $0, 32       ;Barra espaciadora
            daddi $s0, $0, 0        ;Coordenada X
            daddi $s1, $0, 0        ;Coordenada Y
            daddi $s2, $0, color1   ;Direccion del color inicial
            daddi $s3, $0, 0        ;Modo

loop:       sd $t0, 0($s6)
            lbu $s4, 0($s7)         ;Tomar caracter
            bne $s4, $t2, sigo
            xori $s3, $s3, 1        ;Cambio el modo
            j loop
    
sigo:       slti $t1, $s4, 48       ;48 = '0', t1 = 1 -> Caracter mal ingresado
            bnez $t1, loop          ;Salto si el caracter fue mal ingresado
            
            slti $t1, $s4, 57       ;57 = '9', t1 = 1 -> Cambiar color
            beqz $t1, sigo2         ;Salto si no debo cambiar color

            daddi $s2, $0, color1   ;Actualizo el color
            daddi $s4, $s4, -49     ;Resto 49 para obtener la cantidad de colores a desplazar
            daddi $t3, $0, 8        ;Un desplazamiento
            dmul $t3, $t3, $s4      ;Desplazmiento total
            daddi $s2, $s2, $t3     
            
            j loop
;Comparo si debo moverme
sigo2:      daddi $t3, $0, 0        ;Corrimiento en X
            daddi $t4, $0, 0        ;Corrimiento en Y
            daddi $t2, $0, 97       ;97 = 'a'
            bne $s4, $t2, no_izq
            daddi $t3, $0, -1
            j print

no_izq:     daddi $t2, $0, 100      ;100 = 'd'
            bne $s4, $t2, no_der
            daddi $t3, $0, 1
            j print

no_der:     daddi $t2, $0, 115      ;115 = 's'
            bne $s4, $t2, no_abajo
            daddi $t4, $0, -1
            j print

no_abajo:   daddi $t2, $0, 119      ;119 = 'w'
            bne $s4, $t2, loop
            daddi $t4, $0, 1

moverme:    beqz $t3, movY          ;Para saber que movimiento hago en X o en Y
            dadd $t5, $s0, $t3
            slti $t6, $t5, 50       ;t6 = 1 -> Si no me pase
            beqz $t6, loop          ;Salto a loop si me pase
            slti $t6, $t5, 0        ;t6 = 0 -> Si no me pase
            bnez $t6, loop          ;Salto a loop si me pase

            daddi $s0, $s0, $t3     ;Nueva posicion en X
            j actualizar

movY:       dadd $t5, $s1, $t4
            slti $t6, $t5, 50       ;t6 = 1 -> Si no me pase
            beqz $t6, loop          ;Salto a loop si me pase
            slti $t6, $t5, 0        ;t6 = 0 -> Si no me pase
            bnez $t6, loop          ;Salto a loop si me pase

            daddi $s1, $s1, $t4     ;Nueva posicion en Y

actualizar: ;Debo actualizar el punto al cual me movi, tengo que preguntar en que modo estoy para saber si pinto o no, y despues debo imprimir todo en la pantalla

            jal print

            j loop


halt

;En $a0 recibo CONTROL
;En $a1 recibo DATA
;En $a2 recibo la posicion inicial del tablero

print: