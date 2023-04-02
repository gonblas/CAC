ORG 1000H
cadena DB ?


ORG 2000H
        MOV BX, OFFSET cadena
        MOV AL, 0
LOOP:   INT 6
        CMP BYTE PTR [BX], 0DH
        JZ FIN
        INC BX
        INC AL
        JMP LOOP

FIN:    MOV BX, OFFSET cadena
        INT 7
        HLT
END