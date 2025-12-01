`timescale 1ns/1ns

module MEM_WB_Buffer (
    input clk,
    input reset,

    // --- ENTRADAS (Vienen de la etapa MEM) ---

    // 1. Señales de Control WB (Las únicas sobrevivientes)
    input RegWrite_in,
    input MemToReg_in,

    // 2. Datos
    input [31:0] ReadData_in,  // Dato leído de la RAM (si fue un Load)
    input [31:0] ALU_Result_in,// Resultado de la ALU (pasó de largo por la etapa MEM)
    input [4:0]  WriteReg_in,  // Registro destino (que cargamos desde ID)

    // --- SALIDAS (Van a la etapa WB) ---

    output reg RegWrite_out,
    output reg MemToReg_out,

    output reg [31:0] ReadData_out,
    output reg [31:0] ALU_Result_out,
    output reg [4:0]  WriteReg_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Limpieza (Flush)
            RegWrite_out   <= 0;
            MemToReg_out   <= 0;
            ReadData_out   <= 32'b0;
            ALU_Result_out <= 32'b0;
            WriteReg_out   <= 5'b0;
        end 
        else begin
            // Transporte
            RegWrite_out   <= RegWrite_in;
            MemToReg_out   <= MemToReg_in;
            ReadData_out   <= ReadData_in;
            ALU_Result_out <= ALU_Result_in;
            WriteReg_out   <= WriteReg_in;
        end
    end

endmodule
