ORG 1000H
ROTACIONES DB 4
NUMERO DB 1

ORG 3000H
ROTARIZQ:   PUSH BX
            PUSH CX
            PUSHF
FOR:        ADD AL, AL      ;Duplicamos el numero (Rotar a la izquierda)
            JC CARRY        ;Si se prende el carry, sumamos uno
            JMP SIG
CARRY:      INC AL
SIG:        DEC CH          ;Decrementamos CH (Cantidad de rotaciones a izquierda)
            JNZ FOR         ;Mientras queden rotaciones, saltamos al FOR
FIN:        MOV [BX], AL    ;Guardamos el numero rotado en memoria
            POPF            ;Recuperamos Datos
            POP CX          
            POP BX
            RET

ORG 2000H
            MOV CH,ROTACIONES
            MOV AL, NUMERO
            CALL ROTARIZQ
            HLT
END