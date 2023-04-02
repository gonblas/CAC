ORG 1000H
            CADENA DB "Ingrese la clave: "
            BIEN DB "Acceso permitido"
            MAL DB "Acceso denegado"
            KEY DB "1985"
            DIG DB ?,?,?,?
            LENGHT EQU 4

ORG 2000H
            MOV BX, OFFSET DIG
            MOV AL, 1
            MOV AH, 0
                                    ;Leo la clave ingresada
LOOP1:      INT 6
            INC BX
            INC AH
            CMP AH, LENGHT
            JNZ LOOP1
                                    ;Comparo las claves
            MOV BX, OFFSET KEY
            MOV AX, 0
COMPARAR:   MOV CL, [BX]
            PUSH BX
            MOV BX, OFFSET DIG
            ADD BX, AX
            CMP CL, [BX]
            JNZ DENEGADO
            POP BX
            INC BX
            INC AX
            CMP AX, LENGHT
            JNZ COMPARAR

            MOV BX, OFFSET BIEN
            MOV AL, OFFSET MAL - OFFSET BIEN
            JMP FIN

DENEGADO:   MOV BX, OFFSET MAL
            MOV AL, OFFSET KEY - OFFSET MAL
            
FIN:        INT 7
            HLT
            END