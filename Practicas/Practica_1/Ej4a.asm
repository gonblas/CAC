ORG 2000H
        MOV AL, 4
        MOV BL, 5
        MOV CL, 0

IF:     CMP BL, AL
        JNS THEN
        MOV CL, BL
        JMP FIN
THEN:   MOV CL, AL

FIN:    HLT
        END