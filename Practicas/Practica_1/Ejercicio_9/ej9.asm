ORG 1000H
CADENA DB "GONZALO0"

ORG 3000H
CONCAR: PUSH BX
        PUSH DX
WHILE:  CMP DL, [BX]                     ;Mientras no se llegue al caracter de terminacion
        JZ FIN
        INC CL                          ;Aumentamos la cantidad de caracteres
        INC BX                          ;Pasamos a la direccion en memoria del sig. caract.
        JMP WHILE
FIN:    POP DX
        POP BX
        RET

ORG 2000H
            MOV BX, OFFSET CADENA
            MOV DL, 48
            MOV CL, 0                  ;Inicializo el contador en 0
            CALL CONCAR
            HLT
END