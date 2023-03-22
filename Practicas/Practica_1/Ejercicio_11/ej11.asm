ORG 1000H
CADENA DB "GAAZALO0"
FIN_CADENA DB ?
CAR DB "A"
;En BX la posicion de la cadena, En DL el largo de la misma, En DH el caracter a contar y reemplazar por 'X' 
;En CL el contador de esa letra.
ORG 3000H
CONCAR: PUSH BX
        PUSH DX
WHILE:  CMP DL, 0                      ;Mientras no se llegue al final
        JZ FIN
        CMP DH, [BX]
        JNZ SIGO
        INC CL
        MOV BYTE PTR [BX],88
SIGO:   INC BX  
        DEC DL                        ;Pasamos a la direccion en memoria del sig. caract.
        JMP WHILE
FIN:    POP DX
        POP BX
        RET

ORG 2000H
        MOV BX, OFFSET CADENA
        MOV DL, OFFSET FIN_CADENA -OFFSET CADENA
        MOV DH, CAR
        MOV CL, 0                     ;Inicializo el contador en 0
        CALL CONCAR
        HLT
END