ORG 2000H
        MOV AL, 5
        MOV BL, 10
        MOV CL, 0

IF:     CMP AL, BL
        JNS ELSE
        MOV CL, AL
        JMP FIN
ELSE:   MOV CL, BL

FIN:    HLT
        END