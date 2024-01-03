def main():
    # Abre el archivo de texto
    with open("archivo.txt", "r") as f:
        # Lee todo el contenido del archivo
        datos = f.read()

    # Recorre el buffer byte a byte
    numero = 0
    for caracter in datos:
        # Si el caracter es un salto de línea o un espacio en blanco, significa que se ha terminado de leer un número
        if caracter == "\n" or caracter == " ":
            # Imprime el número
            print(numero)
            # Reinicia el número
            numero = 0
        else:
            # Convierte el caracter a su valor numérico
            numero = numero * 10 + ord(caracter) - ord("0")

# Llama a la función main
if __name__ == "__main__":
    main()
