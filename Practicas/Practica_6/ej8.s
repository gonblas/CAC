                .data
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
color_pelota1:   .word32 0x00FF0000  ; Azul
color_pelota2:   .word32 0x0000FF00  ; XXXXXX
color_pelota3:   .word32 0x000000FF  ; XXXXXX
color_pelota4:   .word32 0x00FFFF00  ; XXXXXX
color_pelota5:   .word32 0x00FF00FF  ; XXXXXX
color_fondo:    .word32 0x00FFFFFF  ; Blanco


                .text
                lwu $a0, CONTROL($0)
                lwu $a1, DATA($0)
                daddi $sp, $0, 0x400

                lwu $a3, color_fondo($0)
                
; color -> posX -> posY -> dirX -> dirY


                lwu $t0, color_pelota1($0)   ; Color
                daddi $t1, $0, 35            ; Coordenada X de la pelota
                daddi $t2, $0, 15            ; Coordenada Y de la pelota
                daddi $t3, $0, 1             ; Dirección X de la pelota
                daddi $t4, $0, -1            ; Dirección Y de la pelota
                daddi $sp, $sp, -40          ; Cargo datos de pelota 1
                sd $t4, 0($sp)
                sd $t3, 8($sp)
                sd $t2, 16($sp)
                sd $t1, 24($sp)
                sd $t0, 32($sp)


                lwu $t0, color_pelota2($0)   ; Color
                daddi $t1, $0, 12            ; Coordenada X de la pelota
                daddi $t2, $0, 12            ; Coordenada Y de la pelota
                daddi $t3, $0, 1             ; Dirección X de la pelota
                daddi $t4, $0, -1            ; Dirección Y de la pelota
                daddi $sp, $sp, -40          ; Cargo datos de pelota 2
                sb $t4, 0($sp)
                sb $t3, 8($sp)
                sb $t2, 16($sp)
                sb $t1, 24($sp)
                sd $t0, 32($sp)


                lwu $t0, color_pelota3($0)   ; Color
                daddi $t1, $0, 35            ; Coordenada X de la pelota
                daddi $t2, $0, 40            ; Coordenada Y de la pelota
                daddi $t3, $0, -1            ; Dirección X de la pelota
                daddi $t4, $0, -1            ; Dirección Y de la pelota
                daddi $sp, $sp, -40          ; Cargo datos de pelota 3
                sd $t4, 0($sp)
                sd $t3, 8($sp)
                sd $t2, 16($sp)
                sd $t1, 24($sp)
                sd $t0, 32($sp)


                lwu $t0, color_pelota4($0)   ; Color
                daddi $t1, $0, 1             ; Coordenada X de la pelota
                daddi $t2, $0, 1             ; Coordenada Y de la pelota
                daddi $t3, $0, 1             ; Dirección X de la pelota
                daddi $t4, $0, 1             ; Dirección Y de la pelota
                daddi $sp, $sp, -40          ; Cargo datos de pelota 4
                sd $t4, 0($sp)
                sd $t3, 8($sp)
                sd $t2, 16($sp)
                sd $t1, 24($sp)
                sd $t0, 32($sp)


                lwu $t0, color_pelota5($0)   ; Color
                daddi $t1, $0, 1             ; Coordenada X de la pelota
                daddi $t2, $0, 40            ; Coordenada X de la pelota
                daddi $t3, $0, -1            ; Dirección X de la pelota
                daddi $t4, $0, -1            ; Dirección Y de la pelota
                daddi $sp, $sp, -40          ; Cargo datos de pelota 5
                sd $t4, 0($sp)
                sd $t3, 8($sp)
                sd $t2, 16($sp)
                sd $t1, 24($sp)
                sd $t0, 32($sp)


loop:           daddi $a2, $0, 1    ;Pelota 1 (Pelota 1 tiene numero 1)
                jal pelota

                daddi $a2, $a2, 1   ;Pelota 2
                jal pelota

                daddi $a2, $a2, 1   ;Pelota 3
                jal pelota

                daddi $a2, $a2, 1   ;Pelota 4
                jal pelota

                daddi $a2, $a2, 1   ;Pelota 5
                jal pelota

                daddi $t0, $0, 50   ; Hace una demora para que el rebote no sea tan rápido.
demora:         daddi $t0, $t0, -1  ; Esto genera una infinidad de RAW y BTS pero...
                bnez $t0, demora    ; ¡hay que hacer tiempo igualmente!
                j loop


;En $a0 me pasan CONTROL
;En $a1 me pasan DATA
;En $a2 me pasan el numero de pelota
;En $a3 me pasan el color de fondo
pelota:         daddi $sp, $sp, -40
                sd $s0, 0($sp)
                sd $s0, 8($sp)
                sd $s2, 16($sp)
                sd $s3, 24($sp)
                sd $s4, 32($sp)

                daddi $t0, $0, 0x400         ;Calculo la direccion donde estan los datos
                daddi $t3, $a2, 0            ;Contador para la resta

resta:          daddi $t0, $t0, -40
                daddi $t3, $t3, -1
                bnez $t3, resta


                ;color -> posX -> posY -> dirX -> dirY
                lb $s3, 0($t0)              ; Dirección Y de la pelota
                lb $s2, 8($t0)              ; Dirección X de la pelota
                lb $s1, 16($t0)             ; Coordenada Y de la pelota
                lb $s0, 24($t0)             ; Coordenada X de la pelota
                lwu $v0, 32($t0)            ; Color
                daddi $s4, $0, 5            ; Comando para dibujar un punto
                ;Hasta aca anda bien
                sw $a3, 0($a1)              ; Borra la pelota (pos ant del color de fondo)
                sb $s0, 5($a1)
                sb $s1, 4($a1)
                sd $s4, 0($a0)

                dadd $s0, $s0, $s2           ; Mueve la pelota en la dirección actual
                dadd $s1, $s1, $s3

                daddi $t1, $0, 48            ; Comprueba que la pelota no esté en la columna de más
                slt $t4, $t1, $s0            ; a la derecha. Si es así, cambia la dirección en X.
                dsll $t4, $t4, 1
                dsub $s2, $s2, $t4

                slt $t4, $t1, $s1            ; Comprueba que la pelota no esté en la fila de más arriba.
                dsll $t4, $t4, 1             ; Si es así, cambia la dirección en Y.
                dsub $s3, $s3, $t4

                slti $t4, $s0, 1             ; Comprueba que la pelota no esté en la columna de más
                dsll $t4, $t4, 1             ; a la izquierda. Si es así, cambia la dirección en X.
                dadd $s2, $s2, $t4

                slti $t4, $s1, 1             ; Comprueba que la pelota no esté en la fila de más abajo.
                dsll $t4, $t4, 1             ; Si es así, cambia la dirección en Y.
                dadd $s3, $s3, $t4


                sw $v0, 0($a1)               ; Dibuja la pelota.
                sb $s0, 5($a1)
                sb $s1, 4($a1)
                sd $s4, 0($a0)

                ;Resguardo valores de la pelota que pueden ser modificados
                sd  $s3, 0($t0)              ; Guardo coordenada X de la pelota
                sd  $s2, 8($t0)              ; Guardo coordenada Y de la pelota
                sd  $s1, 16($t0)             ; Guardo dirección X de la pelota
                sd  $s0, 24($t0)             ; Guardo dirección X de la pelota
                sd  $v0, 32($t0)             ; Guardo dirección X de la pelota
                
                ld $s0, 0($sp)
                ld $s0, 8($sp)
                ld $s2, 16($sp)
                ld $s3, 24($sp)
                ld $s4, 32($sp)
                daddi $sp, $sp, 40
                jr $ra