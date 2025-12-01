`timescale 1ns/1ns

module Micro_P_TB;

    // 1. Declaración de señales para conectar al procesador
    reg clk;
    reg reset;

    // 2. Instancia de tu procesador (Device Under Test)
   Micro uut (
        .clk(clk),
        .reset(reset)
    );

    // 3. Generación del Reloj (Clock)
    // Esto crea un reloj con periodo de 10ns (100 MHz)
   initial begin
    clk = 1;
    forever #5 clk = ~clk;
end

// Inicializamos las señales y ejecutamos las pruebas
initial begin
    // Inicialización de señales
    reset =1;
	#1;
	reset=0;
    #1000;
    $finish;
end

endmodule