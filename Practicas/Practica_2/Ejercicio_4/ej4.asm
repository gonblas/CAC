ORG 1000H
        TEXT DB "Ingrese un digito: "
        DIG DB ?

ORG 2000H
        MOV BX, OFFSET TEXT
        MOV AL, OFFSET DIG - OFFSET TEXT
        INT 7
        MOV BX, OFFSET DIG
        INT 6
        MOV AL, 1
        INT 7

        HLT
        END

