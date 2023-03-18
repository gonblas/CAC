ORG 1000H
NUM1 DW 10
NUM2 DW 15

ORG 3000H
SWAP:   PUSH BX        
        PUSH DX
        
        MOV BX, SP
        ADD BX, 6
        PUSH BX
        MOV BX, [BX]
        MOV DX, BX           ;ALMACENO DIR NUM2
        MOV CX, [BX]         ;ALMACENO EL NUM2
        POP BX
        ADD BX, 2            
        MOV BX, [BX]         ;ALMACENO DIR NUM1
        MOV AX, [BX]         ;ALMACENO EL NUM1
        
        MOV [BX], CX
        MOV BX, DX
        MOV [BX], AX
        
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