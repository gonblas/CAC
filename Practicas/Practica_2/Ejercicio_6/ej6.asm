ORG 1000H
            NUM_0 DB "Cero  "
            NUM_1 DB "Uno   "
            NUM_2 DB "Dos   "
            NUM_3 DB "Tres  "
            NUM_4 DB "Cuatro"
            NUM_5 DB "Cinco "
            NUM_6 DB "Seis  "
            NUM_7 DB "Siete "
            NUM_8 DB "Ocho  "
            NUM_9 DB "Nueve "
            TEXT DB "Ingrese digitos (doble 0 finaliza): "
            DIG DB ?

ORG 2000H
            MOV DL, 1                ;Donde almaceno el anterior digito leido
            MOV BX, OFFSET TEXT
            MOV AL, OFFSET DIG - OFFSET TEXT
            INT 7             
            MOV BX, OFFSET DIG 
            MOV AL, 1
WHILE:      INT 6
            CMP BYTE PTR [BX], 48   ;Comparo si se leyo el 0
            JNZ SIGO
            CMP DL, 48              ;Comparo si el anterior es 0
            JZ FIN
SIGO:       MOV DL, DIG
            PUSH DX                 ;Guardo el numero actual que sera el anterior en la prox vuelta
            SUB DL, 48
            PUSH BX
            PUSH AX
            MOV AL, 6              ;Cargo la cantidad de letras para imprimir un numero
            MOV BX, OFFSET NUM_0

SUMO:       DEC DL                 ;Me muevo a la direccion donde se encuentra la cadena del numero
            CMP DL, 0
            JS NO_SUMO
            ADD BX, 6
            JMP SUMO
NO_SUMO:    INT 7                  ;Imprimo la cadena
            POP AX
            MOV BX, 10             ;\n
            INT 7                  ;Imprimo un salto de linea
            POP BX
            POP DX
            JMP WHILE

FIN:        HLT
            END