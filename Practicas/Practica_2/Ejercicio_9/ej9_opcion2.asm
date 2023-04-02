ORG 1000H
            CADENA DB "Ingrese la clave: "
            BIEN DB "Acceso permitido"
            MAL DB "Acceso denegado"
            KEY DB "1985"
            DIG DB ?
            LENGHT EQU 4

ORG 2000H
            MOV BX, OFFSET DIG
            MOV AL, 1

            MOV DX, 0
            
LOOP1:      INT 6
            MOV CL, [BX]
            PUSH BX
            MOV BX, OFFSET KEY
            ADD BX, DX
            CMP CL, [BX]
            POP BX
            JNZ DENEGADO
            INC DX
            CMP DX, LENGHT
            JNZ LOOP1

            MOV BX, OFFSET BIEN
            MOV AL, OFFSET MAL - OFFSET BIEN
            JMP FIN

DENEGADO:   MOV BX, OFFSET MAL
            MOV AL, OFFSET KEY - OFFSET MAL
            
FIN:        INT 7
            HLT
            END