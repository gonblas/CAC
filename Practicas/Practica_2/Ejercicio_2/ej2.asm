ORG 1000H
        CAR DB 01H

ORG 2000H
        MOV CL, 255              ;Contador de caracteres
        MOV BX, OFFSET CAR
        MOV AL, 1

LOOP1:  INT 7
        ADD BYTE PTR [BX], 1
        DEC CL
        JNZ LOOP1

        HLT
        END
