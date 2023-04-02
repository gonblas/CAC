ORG 1000H
            TEXT DB "Ingrese un digito: "
            DIG DB ?
            INVALID DB "Caracter no valido"
            INVALID_FIN DB ?

ORG 3000H
ES_NUM:     PUSH AX
            PUSH BX
            PUSHF
            MOV DL, 0FFH
            MOV AH, [BX]
            CMP AH, 30H
            JS NO_NUM
            CMP AH, 39H
            JS FIN_ES_NUM

NO_NUM:     MOV BX, OFFSET INVALID
            MOV AL, OFFSET INVALID_FIN - OFFSET INVALID
            INT 7
            MOV DL, 0

FIN_ES_NUM: POPF
            POP BX
            POP AX
            RET

ORG 2000H
            MOV BX, OFFSET TEXT
            MOV AL, OFFSET DIG - OFFSET TEXT
            INT 7
            MOV BX, OFFSET DIG
            INT 6
            CALL ES_NUM
            CMP DL, 0FFH
            JNZ FIN
            MOV AL, 1
            INT 7

FIN:        HLT
            END