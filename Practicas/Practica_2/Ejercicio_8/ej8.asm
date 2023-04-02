ORG 1000H
            CADENA DB "Ingrese dos digitos: "
            NEGATIVO EQU 45
            DIG DB ?

ORG 2000H
            MOV BX, OFFSET CADENA
            MOV AL, OFFSET DIG - OFFSET CADENA
            INT 7          ;Imprimo el mensaje
            MOV BX, OFFSET DIG
            INT 6
            MOV CL, DIG    ;Cargo el primer digito en CL
            INT 6
            MOV CH, DIG    ;Cargo el primer digito en CH
            SUB CL, 48
            SUB CH, 48
            SUB CL, CH     ;Almaceno el resultado en CL

            CMP CL, 0
            JNS POSITIVO
            
            MOV AL, 1
            MOV BYTE PTR [BX], NEGATIVO
            INT 7
            MOV CH, 0
ABS:        INC CH
            INC CL
            JNZ ABS
            MOV CL, CH
            
POSITIVO:   ADD CL, 48
            MOV [BX], CL
            MOV AL, 1
            INT 7
            
FIN:        HLT
            END