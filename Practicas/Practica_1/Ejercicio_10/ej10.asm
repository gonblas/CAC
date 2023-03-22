ORG 1000H
NUM1 DW 10
NUM2 DW 15

ORG 3000H
;Aclaraciones: Guardamos en AX la posicion en memoria del dato 1, 
;y en CX la del dato 2

SWAP:   PUSH BX        ;Guardamos Datos
        PUSH DX
        
        MOV BX, SP
        ADD BX, 8
        PUSH BX
        MOV BX, [BX]
        MOV CX, BX     ;Guardo en CX la direccion del dato1
        MOV AX, [BX]     ;Guardo en AX el valor del dato1
        POP BX 
        SUB BX, 2
        MOV BX, [BX]   ;Guardo en BX la direccion del dato2
        MOV DX, [BX]   ;Guardo en DX el valor del dato2

        MOV WORD PTR [BX],AX
        MOV BX, CX
        MOV WORD PTR [BX],DX

        POP DX         ;Recuperamos Datos
        POP BX
RET

ORG 2000H
        MOV AX, OFFSET NUM1
        MOV CX, OFFSET NUM2
        PUSH AX
        PUSH CX
        CALL SWAP
        POP CX
        POP AX
        HLT
END