import sys

if(len(sys.argv) < 2):
    print("Usage: python link88.py <filename>")
    sys.exit(1)

filename = sys.argv[1]

with open(filename, "rb") as f:
    contenido = f.read()

filename_eje = filename.rsplit('.',1)[0]+ '.eje'

with open(filename_eje,'wb') as f:
    f.write(b'Fichero Ejecutable!!\n\n')
    f.write(contenido)
