                .data
valor:          .word 10
result:         .word 0

                .text
                daddi $sp, $0, 0x400   ;Inicializa el puntero al tope de la pila (1)
                ld $a0, valor($0)
                jal factorial
                sd $v0, result($0)
                halt

;a0: Numero al cual sacar el factorial
factorial:      daddi $sp, $sp, -16    ;Resguardo la direccion de retorno
                sd $ra, 0($sp)
                sd $s0, 8($sp)
                slti $t0, $a0, 2       ;Caso base: t0=1 si a0=1
                beqz $t0, recursivo
                daddi $v0, $0, 1
                j fin

recursivo:      dadd $s0, $0, $a0
                daddi $a0, $a0, -1 
                jal factorial          ;Llamos recursivamente con (num-1)
                dmul $v0, $s0, $v0     ;Realizo la multiplicacion del numero con el factorial del anterior

fin:            ld $ra, 0($sp)
                ld $s0, 8($sp)
                daddi $sp, $sp, 16
                jr $ra

;b) No es posible sin la implementacion de una pila ya que para muchas llamadas recursivas los registros
;   se agotan.