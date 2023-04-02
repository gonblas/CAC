ORG 1000H
            CADENA DB "Ingrese dos digitos: "
            NUM1 EQU 49
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
            ADD CL, CH     ;Almaceno el resultado en CL

            CMP CL, 10
            JNS DOS_DIG
            
            MOV AL, 1
            ADD CL, 48
            MOV [BX], CL
            INT 7
            JMP FIN
            
DOS_DIG:    INC BX
            SUB CL, 10
            ADD CL, 48
            MOV [BX], CL
            DEC BX
            MOV BYTE PTR [BX], NUM1
            MOV AL, 2
            INT 7
            
FIN:        HLT
            END