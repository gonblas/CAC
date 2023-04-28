        HAND EQU 40H
ORG 1000H
        MSJ DB "Ingrese 5 digitos: "
        DIG DB ?,?,?,?,?
        FIN_DIG DB ?

ORG 2000H
        IN AL, HAND+1
        AND AL, 7FH
        OUT HAND+1, AL ;Pongo el bit 7 de State para hacer polling
        MOV BX, OFFSET MSJ
        MOV AL, OFFSET DIG - OFFSET MSJ
        INT 7
        MOV BX, OFFSET DIG
        MOV AL, OFFSET FIN_DIG - OFFSET DIG
LOOP:   INT 6
        INC BX
        DEC AL
        JNZ LOOP

        MOV BX, OFFSET DIG
        MOV CL, OFFSET FIN_DIG - OFFSET DIG
POLL1:  IN AL, HAND+1
        AND AL, 1
        JNZ POLL1
        MOV AL, [BX]
        OUT HAND, AL
        INC BX
        DEC CL
        JNZ POLL1

        DEC BX
        MOV CL, OFFSET FIN_DIG - OFFSET DIG
POLL2:  IN AL, HAND+1
        AND AL, 1
        JNZ POLL2
        MOV AL, [BX]
        OUT HAND, AL
        DEC BX
        DEC CL
        JNZ POLL2
        HLT
        END