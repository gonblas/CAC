ORG 1000H
VOC DB "aeiouAEIOU"
FINVOC DB ?
CADENA DB "Gon"
FIN_CADENA DB ?

ORG 3000H

ES_VOCAL:   PUSH AX
            PUSH BX  
            PUSH CX                   ;Guardamos el dato
            PUSHF                     ;Guardamos las flags
            MOV DL, 0                 ;DL guarda el resultado
SIGUE:      CMP CL, [BX]              ;Comparamos si es vocal
            JZ TRUE                   ;Saltamos si es vocal              
            INC BX                    ;Nos movemos en la tabla
            DEC AL                    ;Decrementamos AL (Contador)
            JNZ SIGUE
            JMP FIN
TRUE:       MOV DL, 0FFH              ;Guardamos si es vocal en DL
FIN:        POPF                      ;Recuperamos los datos almacenados en la pila
            POP CX
            POP BX                    ;Guarda primera vocal
            POP AX                    ;Guarda total de vocales (Contador)
            RET

VOCALES:    PUSH AX
            PUSH BX
            PUSH CX
            PUSHF
            MOV DH, 0                 ;Contador de vocales
FOR:        CMP AH, 0
            JZ FIN2
            PUSH BX
            MOV CL, [BX]
            MOV BX, OFFSET VOC
            MOV AL, OFFSET FINVOC - OFFSET VOC
            CALL ES_VOCAL
            POP BX
            CMP DL, 0FFH
            JNZ SIGO
            INC DH
SIGO:       INC BX
            DEC AH
            JMP FOR

FIN2:       POPF
            POP CX
            POP BX
            POP AX
            RET
ORG 2000H
            MOV BX, OFFSET CADENA
            MOV AH, OFFSET FIN_CADENA - OFFSET CADENA
            CALL VOCALES
            HLT
END