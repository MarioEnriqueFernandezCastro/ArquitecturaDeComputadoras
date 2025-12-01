`timescale 1ns/1ns

module ID_EX_Buffer(
    input clk,
    input reset,

    // --- ENTRADAS (Vienen de los cables de tu módulo TypeR actual) ---
    
    // Señales de Control para WB (Write Back)
    input BR_En_in,      // Tu señal de escritura en Banco (RegWrite)
    input Mem_to_BR_in,  // Tu señal de Mux Memoria/ALU (MemToReg)

    // Señales de Control para MEM (Memory)
    input Branch_in,     // Branch_to_AND
    input MemW_in,       // EnW
    input MemR_in,       // EnR

    // Señales de Control para EX (Execute)
    input RegDst_in,     // RegDst_to_Mux
    input ALUSrc_in,     // ALUSrc_to_Mux
    input [2:0] AluOp_in,// AluOp directo de la UC

    // Datos del Datapath
    input [31:0] PC_Plus4_in,  // Tu cable "Add"
    input [31:0] Dato1_in,     // Tu cable "d1BR_op1Alu"
    input [31:0] Dato2_in,     // Tu cable "d2BR_op2Alu"
    input [31:0] SignExt_in,   // Tu cable "Sign_to_Shift"

    // Campos de la instrucción necesarios
    input [4:0] Rt_in,         // mem_inst[20:16]
    input [4:0] Rd_in,         // mem_inst[15:11]
    input [5:0] Funct_in,      // mem_inst[5:0] (Para el ALU Control)

    // --- SALIDAS (Nuevos cables que irán a la ALU y Muxes en EX) ---

    output reg BR_En_out,
    output reg Mem_to_BR_out,

    output reg Branch_out,
    output reg MemW_out,
    output reg MemR_out,

    output reg RegDst_out,
    output reg ALUSrc_out,
    output reg [2:0] AluOp_out,

    output reg [31:0] PC_Plus4_out,
    output reg [31:0] Dato1_out,
    output reg [31:0] Dato2_out,
    output reg [31:0] SignExt_out,

    output reg [4:0] Rt_out,
    output reg [4:0] Rd_out,
    output reg [5:0] Funct_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Limpieza (Flush) a ceros
            BR_En_out     <= 0;
            Mem_to_BR_out <= 0;
            Branch_out    <= 0;
            MemW_out      <= 0;
            MemR_out      <= 0;
            RegDst_out    <= 0;
            ALUSrc_out    <= 0;
            AluOp_out     <= 0;
            PC_Plus4_out  <= 0;
            Dato1_out     <= 0;
            Dato2_out     <= 0;
            SignExt_out   <= 0;
            Rt_out        <= 0;
            Rd_out        <= 0;
            Funct_out     <= 0;
        end 
        else begin
            // Pasar datos
            BR_En_out     <= BR_En_in;
            Mem_to_BR_out <= Mem_to_BR_in;
            Branch_out    <= Branch_in;
            MemW_out      <= MemW_in;
            MemR_out      <= MemR_in;
            RegDst_out    <= RegDst_in;
            ALUSrc_out    <= ALUSrc_in;
            AluOp_out     <= AluOp_in;
            PC_Plus4_out  <= PC_Plus4_in;
            Dato1_out     <= Dato1_in;
            Dato2_out     <= Dato2_in;
            SignExt_out   <= SignExt_in;
            Rt_out        <= Rt_in;
            Rd_out        <= Rd_in;
            Funct_out     <= Funct_in;
        end
    end

endmodule
