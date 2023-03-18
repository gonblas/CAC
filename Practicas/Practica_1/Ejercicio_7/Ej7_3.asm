;Para datos de tipo byte
ORG 1000H
NUM1 DB 5
NUM2 DB 9

ORG 3000H
MULT: PUSH AX
PUSH BX
PUSH CX
PUSHF

MOV BX, AX
MOV AL, [BX]
MOV BX, CX
MOV CL, [BX]


CMP AL, CL
JNS LOOP
PUSH AX
MOV AL, CL
POP CX

MOV AH, 0

CMP CL, 0
JZ FIN_MULT

LOOP: CMP CL, 0
JZ FIN_MULT
ADD AH, AL
DEC CL
JMP LOOP

FIN_MULT: MOV [BX], AH
POPF
POP CX
POP BX
POP AX
RET

ORG 2000H

MOV AX, OFFSET NUM1
MOV CX, OFFSET NUM2
CALL MULT
HLT
END


;Para datos de tipo word
ORG 1000H
NUM1 DW 5
NUM2 DW 9

ORG 3000H
MULT: PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSHF

MOV BX, AX
MOV AX, [BX]
MOV BX, CX
MOV CX, [BX]

MOV DX, 0

CMP AX, CX
JNS LOOP
PUSH AX
MOV AX, CX
POP CX

CMP CX, 0
JZ FIN_MULT

LOOP: CMP CX, 0
JZ FIN_MULT
ADD DX, AX
DEC CX
JMP LOOP

FIN_MULT: MOV [BX], DX
POPF
POP DX
POP CX
POP BX
POP AX
RET

ORG 2000H

MOV AX, OFFSET NUM1
MOV CX, OFFSET NUM2
CALL MULT
HLT
END