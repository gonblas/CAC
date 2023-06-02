.data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
ERROR:      .asciiz "Intente nuevamente: "
TXT:        .asciiz "Ingrese un numero de un digito: "
CERO:       .asciiz "CERO  "
UNO:        .asciiz "UNO   "
DOS:        .asciiz "DOS   "
TRES:       .asciiz "TRES  "
CUATRO:     .asciiz "CUATRO"
CINCO:      .asciiz "CINCO "
SEIS:       .asciiz "SEIS  "
SIETE:      .asciiz "SIETE "
OCHO:       .asciiz "OCHO  "
NUEVE:      .asciiz "NUEVE "
            .code
            lwu $a0, CONTROL($0)
            lwu $a1, DATA($0)
            jal ingreso
            dadd $a2, $0, $v0
            lwu $a0, CONTROL($0)
            lwu $a1, DATA($0)
            jal muestra
            halt

;Recibe en $a0 la direccion de CONTROL
;Recibe en $a1 la direccion de DATA
;Devuelve en $v0 el numero de un digito leido
ingreso:    daddi $t4, $0, TXT
            sd $t4, 0($a1)
            daddi $t4, $0, 4   ;Imprimir un String
            sd $t4, 0($a0)

            daddi $t0, $0, 8   ;Codigo para lectura de un numero
            daddi $t3, $0, 1   
loop:       sd $t0, 0($a0)     ;Envio a control la señal de lectura de un numero
            ld $t1, 0($a1)     ;Tomo el numero ingresado
            slti $t2, $t1, 10  ;Comparo si es de un digito ($t2=1 si esta bien)
            beqz $t2, error
            slti $t2, $t1, -1  ;$t2 = 0 esta bien
            beqz $t2, acierto
error:      daddi $t4, $0, ERROR
            sd $t4, 0($a1)
            daddi $t4, $0, 4   ;Imprimir un String
            sd $t4, 0($a0)
            j loop

acierto:    dadd $v0, $0, $t1
            jr $ra


;Recibe en $a0 la direccion de CONTROL
;Recibe en $a1 la direccion de DATA
;Recibe en $a2 el numero a imprimir
muestra:    daddi $t1, $0, 8   ;Largo de cada cadena incluyendo el caracter de terminacion
            daddi $t0, $0, CERO
            dmul $t3, $t1, $a2  ;Desplazamiento para llegar a la cadena requerida
            dadd $t0, $t0, $t3

print:      sd $t0, 0($a1)
            daddi $t2, $0, 4   ;Imprimir un String
            sd $t2, 0($a0)
            jr $ra
