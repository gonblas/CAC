        PIC EQU 20H
        HAND EQU 40H
        N_HND EQU 10
ORG 40
        IP_HND DW RUT_HND

ORG 1000H
        MSJ DB "Ingrese 5 digitos: "
        DIG DB ?,?,?,?,?
        FIN_DIG DB ?

ORG 3000H
RUT_HND:PUSH AX
        PUSH CX
FOR2:   IN AL, HAND+1
        AND AL, 1
        JNZ FOR2
        MOV AL, [BX]
        OUT HAND, AL
        ADD BX, DX
        DEC CL
        JNZ FOR2
        CMP DX, -1
        JNZ SIGO
        INT 0
SIGO:   MOV DX, -1
        DEC BX
        MOV AL, 20H
        OUT PIC, AL
        POP CX
        POP AX
        IRET


ORG 2000H
        CLI
        MOV BX, OFFSET MSJ
        MOV AL, OFFSET DIG - OFFSET MSJ
        INT 7
        MOV BX, OFFSET DIG
        MOV CL, OFFSET FIN_DIG - OFFSET DIG
FOR:    INT 6     ;Leo los caracteres
        INC BX
        DEC CL
        JNZ FOR
        
        MOV AL, 0FBH
        OUT PIC+1, AL
        MOV AL, N_HND
        OUT PIC+6, AL
        MOV AL, 80H
        OUT HAND+1, AL   ;Forzamos el bit 7 del registro state en 1: para realizar interrupciones
        MOV CL, OFFSET FIN_DIG - OFFSET DIG
        MOV BX, OFFSET DIG
        MOV DX, 1
        STI
LAZO:   JMP LAZO
        HLT
        END
