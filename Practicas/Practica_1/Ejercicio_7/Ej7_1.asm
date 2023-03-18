;Para datos de tipo byte
ORG 1000H
NUM1 DB 4
NUM2 DB 5
RES DB ?

ORG 2000H

MOV AL, NUM1
MOV CL, NUM2
MOV AH, 0
CMP AL,0
JZ FIN

LOOP: CMP CL, 0
JZ FIN
ADD AH, AL
DEC CL
JMP LOOP


FIN: MOV RES, AH
HLT
END

;Para datos de tipo word
ORG 1000H
NUM1 DW 4
NUM2 DW 5
RES DW ?

ORG 2000H

MOV AX, NUM1
MOV CX, NUM2
MOV DX, 0
CMP AX,0
JZ FIN

LOOP: CMP CX, 0
JZ FIN
ADD DX, AX
DEC CX
JMP LOOP


FIN: MOV RES, DX
HLT
END