ORG 2000H
        MOV AL, 4
        MOV BL, 4
        MOV CL, 0

IF:     CMP AL, BL
        JZ THEN
        MOV CL, BL
        JMP FIN
THEN:   MOV CL, AL

FIN:    HLT
        END