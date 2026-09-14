# Práctica 4: Analizador Sintáctico y Gestión de Errores

# Integrantes del Equipo:
1. Cancelada de la O Gerardo Alexander
2. Castellanos Hernández Alan
3. Lara Jiménez Pablo César
4. Medina Robledo Brandon Ernie

# Lenguaje Asignado:
Lenguaje: Estructura sintáctica orientada a C++.

# Reglas Sintácticas Implementadas:
El analizador valida la jerarquía estructural del código mediante CUP y JFlex bajo las siguientes reglas definidas en la gramática:
1. **Archivo:** Compuesto opcionalmente por un paquete y directivas de importación, seguido obligatoriamente por una clase principal y una sección de tolerancia a errores finales (`cola_errores`).
2. **Paquete:** Estructura opcional que inicia con la palabra reservada `package`, un identificador o ruta compuesta (`ruta_paquete`), y finaliza con punto y coma (`;`).
3. **Importaciones y Directivas:** Agrupación de directivas de preprocesador (como `#include <...>` o líneas directas) y sentencias `using namespace ID;`.
4. **Clase Principal:** Estructura conformada por la palabra reservada `class`, un identificador de nombre válido, un cuerpo delimitado estrictamente por llaves (`{ ... }`) y un punto y coma opcional al final.
5. **Cuerpo y Bloques Anidados:** Manejo de instrucciones internas (`elemento_interno`) y subbloques anidados (`bloque`) encerrados entre llaves para soportar la anidación jerárquica típica de C++.

# Tipos de Errores Detectados:
Gracias a la configuración del analizador léxico y sintáctico, el programa identifica:
* **Errores Léxicos:** Caracteres o tokens no reconocidos por las expresiones regulares de JFlex (gestionados mediante `ERROR_LEXICO`).
* **Errores en Paquetes e Importaciones:** Falta de punto y coma, identificadores mal escritos o sintaxis incompleta en las directivas iniciales.
* **Errores en la Clase Principal:** Ausencia del nombre de la clase, llaves desbalanceadas o alteración en el orden jerárquico de los elementos.
* **Errores Estructurales / Fatales:** Tokens inesperados o alteración grave en la estructura global del programa que rompen el flujo gramatical esperado.

# Mecanismos de Recuperación Utilizados:
* **Sobrescritura de `report_error` y `syntax_error`:** Capturan de manera detallada los errores recuperables utilizando las coordenadas del objeto `Symbol`, imprimiendo en consola el mensaje correspondiente, la línea, la columna exacta y el token que provocó el fallo.
* **Sobrescritura de `report_fatal_error`:** Detiene la ejecución e informa cuando ocurre un error crítico que impide continuar con el análisis estructural.
* **Recuperación con Producciones de Sincronización:** Uso de la regla `cola_errores` y el token de escape `error` al final de la gramática CUP, lo que permite al analizador tolerar tokens sobrantes o fallos menores sin interrumpir abruptamente el proceso cuando el archivo presenta desviaciones al final.
* **Retroalimentación Positiva:** Emisión de mensajes claros en consola mediante acciones semánticas (`Regla reconocida: <archivo>`, `<paquete>`, `<importacion>`, `<clase_principal>`) para certificar el avance exitoso del analizador.

# Instrucciones para Compilar y Ejecutar:
Asegúrate de tener instalado Java (JDK) en tu equipo. Abre tu terminal (PowerShell o CMD) y colócate en la carpeta raíz del proyecto. Ejecuta los comandos en el siguiente orden:
# 1. Generar el Analizador Sintáctico con CUP:
java -jar java-cup-11b.jar -parser Parser -symbols sym Parser.cup
# 2. Generar el Analizador Léxico con JFlex:
java -jar jflex-full.jar Lexer.jflex
# 3. Compilar los Archivos Fuente (.java):
javac -encoding UTF-8 -cp ".;java-cup-11b-runtime.jar;java-cup-11b.jar" *.java
# 4. Ejecutar el Programa Principal:
java -Dfile.encoding=UTF-8 -cp ".;java-cup-11b-runtime.jar;java-cup-11b.jar" Main
