/*
 * INTEGRANTES:
 * 1. Cancelada de la O Gerardo Alexander
 * 2. Castellanos Hernandez Alan
 * 3. Lara Jimenez Pablo Cesar
 * 4. Medina Robledo Brandon Ernie
 */

import java.io.FileReader;
import java_cup.runtime.Symbol;

public class Main {
    public static void main(String[] args) {
        System.out.println("--------------------------------------------------------------------------------");
        System.out.println("TRADUCTORES DE LENGUAJE - PR\u00C1CTICA: ANALIZADOR L\u00C9XICO Y SINT\u00C1CTICO");
        System.out.println("INTEGRANTES:");
        System.out.println("1. Cancelada de la O Gerardo Alexander");
        System.out.println("2. Castellanos Hernandez Alan");
        System.out.println("3. Lara Jimenez Pablo Cesar");
        System.out.println("4. Medina Robledo Brandon Ernie");
        System.out.println("--------------------------------------------------------------------------------\n");

        try {
            // 1. ANALISIS LEXICO
            Lexer lexer = new Lexer(new FileReader("act1_Traductores.txt"));
            Symbol s;

            System.out.println("--- INICIO DEL AN\u00C1LISIS L\u00C9XICO ---");
            while ((s = lexer.next_token()).sym != sym.EOF) {
                // Escaneo y despliegue lexico realizado por las funciones token() y error() del Lexer
            }
            System.out.println("--- FIN DEL AN\u00C1LISIS L\u00C9XICO ---\n");

            // 2. ANALISIS SINTACTICO
            Lexer lexerSintactico = new Lexer(new FileReader("act1_Traductores.txt"));
            Parser sintactico = new Parser(lexerSintactico);

            System.out.println("--- INICIO DEL AN\u00C1LISIS SINT\u00C1CTICO ---");
            sintactico.parse();
            System.out.println("--- FIN DEL AN\u00C1LISIS SINT\u00C1CTICO ---\n");

        } catch (Exception e) {
            System.err.println("Error general en la ejecucion: " + e.getMessage());
        }

        System.out.println("--------------------------------------------------------------------------------");
        System.out.println("INTEGRANTES:");
        System.out.println("1. Cancelada de la O Gerardo Alexander");
        System.out.println("2. Castellanos Hernandez Alan");
        System.out.println("3. Lara Jimenez Pablo Cesar");
        System.out.println("4. Medina Robledo Brandon Ernie");
        System.out.println("--------------------------------------------------------------------------------");
    }
}