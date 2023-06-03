                .data

coorX:          .byte 30              ; coordenada X de un punto
coorY:          .byte 30              ; coordenada Y de un punto
color:          .byte 0, 0, 0, 0     ; color: máximo rojo + máximo azul => magenta
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
TXT1:           .asciiz "CoorX (0-49): "
TXT2:           .asciiz "CoorY (0-49): "
TXT3:           .asciiz "Red (0-255): "
TXT4:           .asciiz "Green (0-255): "
TXT5:           .asciiz "Blue (0-255): "

                .text
                
                lwu $s6, CONTROL(r0)  ; $s6 = dirección de CONTROL
                lwu $s7, DATA(r0)     ; $s7 = dirección de DATA

                daddi $a0, $s6, 0
                daddi $a1, $s7, 0

                daddi $a2, $0, TXT1   ; Solicito coordenada X
                jal solicitud
                sb $v0, coorX(r0)

                daddi $a2, $0, TXT2   ; Solicito coordenada Y
                jal solicitud
                sb $v0, coorY(r0)

                daddi $a2, $0, TXT3   ; Solicito color rojo
                jal solicitud
                sb $v0, color(r0)
                
                daddi $s0, $0, 1
                daddi $a2, $0, TXT4   ; Solicito color verde
                jal solicitud
                sb $v0, color($s0)
                
                daddi $s0, $s0, 1
                daddi $a2, $0, TXT5   ; Solicito color azul
                jal solicitud
                sb $v0, color($s0)

                daddi $t0, $0, 7      ; $t0 = 7 -> función 7: limpiar pantalla gráfica
                sd $t0, 0($s6)        ; CONTROL recibe 7 y limpia la pantalla gráfica

                lbu $s0, coorX(r0)    ; $s0 = valor de coordenada X
                sb $s0, 5($s7)        ; DATA+5 recibe el valor de coordenada X
                lbu $s1, coorY(r0)    ; $s1 = valor de coordenada Y
                sb $s1, 4($s7)        ; DATA+4 recibe el valor de coordenada Y
                lwu $s2, color(r0)    ; $s2 = valor de color a pintar
                sw $s2, 0($s7)        ; DATA recibe el valor del color a pintar
                daddi $t0, $0, 5      ; $t0 = 5 -> función 5: salida gráfica
                sd $t0, 0($s6)        ; CONTROL recibe 5 y produce el dibujo del punto
                halt


;Recibe CONTROL en $a0
;Recibe DATA en $a1
;Recibe Direc. de TXT en $a2
;Retorna en $v0 el valor leido
solicitud:      sd $a2, 0($a1)        
                daddi $t0, $0, 4
                sd $t0, 0($a0)

                daddi $t0, $0, 8
                sd $t0, 0($a0)
                ld $v0, 0($a1)
                jr $ra