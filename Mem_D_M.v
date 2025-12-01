`timescale 1ns/1ns

module RAM(
    input [31:0] Datoin,      // Dato a escribir
    input [4:0] Dir,          // Dirección de lectura/escritura
    input WE,                 // Señal de habilitación de escritura
    input RE,                 // Señal de habilitación de lectura
    input clk,                // Señal de reloj
    output reg [31:0] Datoout // Salida del dato leído
);

    // Banco de memoria (64 posiciones de 32 bits cada una)
    reg [31:0] ram [0:63];

    // Inicialización de la memoria desde un archivo
    initial begin
        $readmemb("I_RAM.txt", ram);  // Cargar datos del archivo insram.txt
    end

    // Escritura sincronizada con el flanco de subida del reloj
    always @(posedge clk) begin
        if (WE) begin
            ram[Dir] <= Datoin; // Escribir dato en la dirección especificada
        end
    end

    // Lectura asincrónica (el valor se actualiza inmediatamente cuando RE está activo)
    always @(*) begin
        if (RE) begin
            Datoout = ram[Dir]; // Leer dato desde la dirección especificada
        end else begin
            Datoout = 32'd0; // Dato predeterminado cuando no se está leyendo
        end
    end
endmodule
