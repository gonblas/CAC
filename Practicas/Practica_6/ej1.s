            .data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
texto:      .byte 0                 ; El mensaje a mostrar
.text
            lwu $s0, DATA(r0)       ; $s0 = dirección de DATA
            lwu $s1, CONTROL(r0)    ; $s1 = dirección de CONTROL
            daddi $t0, $0, texto    ; $t0 = dirección del mensaje a leer
                                    ; Obtengo el String
            daddi $t1, $0, 9        ; Señal de lectura de char
            daddi $t2, $0, 13       ; Enter
loop:       sd $t1, 0($s1)          ; Enviar señal para leer char
            lbu $t3, 0($s0)         ; Tomo el caracter
            sb $t3, 0($t0)          ; Almaceno el caracter
            daddi $t0, $t0, 1       ; Avanzo en la cadena
            
            bne $t2, $t3, loop      ; Sigo si no llegue al \n
            
            daddi $t2, $0, 0        ; Caracter de terminacion
            sd $t2, 0($t0)       

            daddi $t0, $0, texto    ; $t0 = dirección del mensaje a mostrar
            sd $t0, 0($s0)          ; DATA recibe el puntero al comienzo del mensaje
            daddi $t0, $0, 6        ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
            sd $t0, 0($s1)          ; CONTROL recibe 6 y limpia la pantalla
            daddi $t0, $0, 4        ; $t0 = 4 -> función 4: salida de una cadena ASCII
            sd $t0, 0($s1)          ; CONTROL recibe 4 y produce la salida del mensaje
            halt