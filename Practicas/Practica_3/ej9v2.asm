;Esta mal
        
        PIC EQU 20H
        HAND EQU 40H
        N_HND EQU 10
ORG 40
        IP_HND DW RUT_HND

ORG 1000H
        MSJ DB "Ingrese 5 caracteres: "
        NUMS DB ?,?,?,?,?
        FIN_NUMS DB ?

ORG 3000H
RUT_HND:PUSH AX
        PUSH CX
FOR2:   MOV AL, [BX]
        OUT HAND, AL
        ADD BX, DX
        DEC CL
        JNZ FOR2
        MOV AL, 20H
        OUT PIC, AL
        POP CX
        POP AX
        IRET

ORG 2000H
        CLI
        MOV BX, OFFSET MSJ
        MOV CL, OFFSET NUMS - OFFSET MSJ
        INT 7
        MOV CL, OFFSET FIN_NUMS - OFFSET NUMS
        MOV BX, OFFSET NUMS
FOR:    INT 6
        INC BX
        DEC CL
        JNZ FOR
        
        MOV AL, 0FBH    ;Desenmascaramos INT2
        OUT PIC+1, AL
        MOV AL, N_HND   ;Enviamos el ID
        OUT PIC+6, AL
        MOV AL, 80H     ;Forzamos el bit 7 del registro state en 1: para realizar interrupciones
        OUT HAND+1, AL  
        MOV CL, OFFSET FIN_NUMS - OFFSET NUMS
        MOV BX, OFFSET NUMS
        STI
        
        MOV DX, 1
        MOV DX, -1
        INT 0
        END