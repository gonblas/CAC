ORG 1000H
ROTACIONES DB 1
NUMERO DB 1

ORG 3000H
ROTARIZQ:   PUSH BX
            PUSH CX
            PUSHF
FOR:        ADD AL, AL      ;Duplicamos el numero (Rotar a la izquierda)
            JNC SIG         ;Si se prende el carry, sumamos uno
            INC AL          ;Incremento si hay carry
SIG:        DEC CH          ;Decrementamos CH (Cantidad de rotaciones a izquierda)
            JNZ FOR         ;Mientras queden rotaciones, saltamos al FOR
FIN:        POPF            ;Recuperamos Datos
            POP CX          
            POP BX
            RET

ROTARDER:   PUSH CX
FOR2:       CMP CL, 0
            JZ FIN2
            MOV CH,7
            CALL ROTARIZQ
            DEC CL
            JMP FOR2

FIN2:       POP CX
            RET

ORG 2000H
            MOV CL, ROTACIONES
            MOV AL, NUMERO
            CALL ROTARDER
            MOV BX, OFFSET NUMERO
            MOV [BX], AL
            HLT
END