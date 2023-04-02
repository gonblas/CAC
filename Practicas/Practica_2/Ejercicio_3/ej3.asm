ORG 1000H
        CAR DB 65

ORG 2000H
        MOV CL, 26               ;Cantidad de letras
        MOV BX, OFFSET CAR
        MOV AL, 1

LOOP1:  INT 7
        ADD BYTE PTR [BX], 32
        INT 7
        SUB BYTE PTR [BX], 31
        DEC CL
        JNZ LOOP1

        HLT
        END
