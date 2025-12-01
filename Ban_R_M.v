`timescale 1ns/1ns

module BR(
                          // Señal de reloj
    input [4:0] AR1, AR2, DE,       // Direcciones para lectura y escritura
    input [31:0] DatoIn,              // Dato a escribir
    input RegWrite,                     // Señal de habilitación de escritura
    input clk,
	output reg [31:0] DR11, Dr22      // Datos leídos
);

    // Declaración del banco de registros
    reg [31:0] BR[0:31]; 

    // Inicialización del banco de registros desde un archivo externo
    initial begin
        $readmemb("MI.txt", BR);
		#10;
    end

    // Proceso de lectura (asincrónica)
    always @(*) begin
        DR11 = BR[AR1]; 
        Dr22 = BR[AR2];
    end

    // Proceso de escritura controlado por reloj
    always @(posedge clk) begin
        if (RegWrite) begin
            BR[DE] <= DatoIn; // Escritura en el banco de registros
        end
    end
endmodule