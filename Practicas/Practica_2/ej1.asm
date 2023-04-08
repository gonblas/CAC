ORG 1000H
        MSJ DB "LIONEL MESSI"
        FIN_MSJ DB ?

ORG 2000H
        MOV BX, OFFSET MSJ
        MOV AL, OFFSET FIN_MSJ - OFFSET MSJ
        INT 7
        HLT
        END