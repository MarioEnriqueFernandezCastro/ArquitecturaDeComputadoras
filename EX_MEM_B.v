`timescale 1ns/1ns

module EX_MEM_Buffer (
    input clk,
    input reset,

    // --- ENTRADAS (Vienen de la etapa EX) ---

    // 1. Señales de Control WB (Siguen de largo)
    input RegWrite_in,
    input MemToReg_in,

    // 2. Señales de Control MEM (Se usan en esta etapa)
    input MemRead_in,
    input MemWrite_in,
    input Branch_in,

    // 3. Datos procesados en EX
    input Zero_in,             // Bandera Zero de la ALU
    input [31:0] ALU_Result_in,// Resultado de la ALU (o dirección calculada)
    input [31:0] StoreData_in, // El dato "B" original (para escribir en RAM si es SW)
    
    // 4. Registro Destino (El ganador entre Rt y Rd)
    input [4:0] WriteReg_in,   

    // --- SALIDAS (Van hacia la etapa MEM) ---

    output reg RegWrite_out,
    output reg MemToReg_out,

    output reg MemRead_out,
    output reg MemWrite_out,
    output reg Branch_out,

    output reg Zero_out,
    output reg [31:0] ALU_Result_out,
    output reg [31:0] StoreData_out,
    output reg [4:0]  WriteReg_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Limpieza (Flush)
            RegWrite_out   <= 0;
            MemToReg_out   <= 0;
            MemRead_out    <= 0;
            MemWrite_out   <= 0;
            Branch_out     <= 0;
            Zero_out       <= 0;
            ALU_Result_out <= 32'b0;
            StoreData_out  <= 32'b0;
            WriteReg_out   <= 5'b0;
        end 
        else begin
            // Transporte de datos
            RegWrite_out   <= RegWrite_in;
            MemToReg_out   <= MemToReg_in;
            MemRead_out    <= MemRead_in;
            MemWrite_out   <= MemWrite_in;
            Branch_out     <= Branch_in;
            Zero_out       <= Zero_in;
            ALU_Result_out <= ALU_Result_in;
            StoreData_out  <= StoreData_in;
            WriteReg_out   <= WriteReg_in;
        end
    end

endmodule
