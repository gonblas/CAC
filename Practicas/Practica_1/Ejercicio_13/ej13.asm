ORG 1000H
VOCALES DB "aeiouAEIOU"
FINVOC DB ?
LETRA DB "X"

ORG 3000H
;Aclaracion: BX tiene que tener la primera posicion de la tabla de vocales
;MOV AL, OFFSET FINVOC - OFFSET VOCALES  ;(Contador)


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
            JMP FINR2
TRUE:       MOV DL, 0FFH              ;Guardamos si es vocal en DL
FINR2:      POPF                      ;Recuperamos los datos almacenados en la pila
            POP CX
            POP BX                    ;Guarda primera vocal
            POP AX                    ;Guarda total de vocales (Contador)
            RET

ORG 2000H
            MOV BX, OFFSET VOCALES
            MOV AL, OFFSET FINVOC - OFFSET VOCALES
            MOV CL, LETRA
            CALL ES_VOCAL
            HLT
END