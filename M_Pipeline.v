`timescale 1ns/1ns
module Micro(
	input clk, reset    
);
wire [31:0] Add_ID;
wire [31:0] mem_inst_ID;
wire BR_enabler_EX;
wire Mem_to_BR_EX;
wire Branch_EX;
wire MemW_EX, MemR_EX;
wire RegDst_EX;
wire ALUSrc_EX;
wire [2:0] AluOp_EX;
wire [31:0] Add_EX;
wire [31:0] d1BR_EX;
wire [31:0] d2BR_EX;
wire [31:0] Sign_EX;
wire [4:0] Rt_EX;
wire [4:0] Rd_EX;
wire [5:0] Funct_EX;
wire BR_enabler_MEM;
wire Mem_to_BR_MEM;
wire MemR_MEM;
wire MemW_MEM;
wire Branch_MEM;
wire Zero_MEM;
wire [31:0] ResAlu_MEM;
wire [31:0] d2BR_MEM;
wire [4:0] WriteReg_MEM;
wire BR_enabler_WB;
wire Mem_to_BR_WB;
wire [31:0] MemD_WB;
wire [31:0] ResAlu_WB;
wire [4:0] WriteReg_WB;
wire [31:0]Mux_out;
wire [31:0]Add_in;
wire [31:0]Add;
wire [31:0]mem_inst;
wire RegDst_to_Mux;
wire [4:0]Mux_to_BR;
wire [31:0] d1BR_op1Alu;
wire [31:0] d2BR_op2Alu;
wire [31:0] DatoMem2BR;
wire [31:0]Sign_to_Shift;//Sign Extend a Shift_left_2
wire [31:0] Shift_AddALU;
wire AND_To_Sel;
wire [31:0] AddALU_to_Mux;
wire Branch_to_AND;
wire Zero_to_AND;
wire ALUSrc_to_Mux;
wire [31:0]Mux_to_ALU;
wire BR_enabler;
wire [2:0] AluOp;
wire MemW;
wire MemR;
wire Mem_to_BR;

wire [31:0] MemD;

wire [2:0] ALUCtrl;
wire [31:0] ResAlu;

wire Jump; 
wire [31:0] JumpAddress;
wire [31:0] NextPC_Branch;

PC inst (
	.clk(clk),
	.reset(reset),
	.pc_in(Mux_out),
	.pc_out(Add_in)
	);
	
add Add_inst(
	.dato1(Add_in),
	.dato2(32'd4),
	.add(Add)
);

MuxAdd uut_inst(
	.sel(AND_To_Sel),
	.A(Add),
	.B(AddALU_to_Mux),
	.C(NextPC_Branch)
	);
	
assign JumpAddress = {Add_ID[31:28], mem_inst_ID[25:0], 2'b00};
MuxJ Mux_Jump_inst(
	.sel(Jump),
	.A(NextPC_Branch),
	.B(JumpAddress),
	.C(Mux_out)
);

Memoria_Instrucciones mem(
	.Direccion(Add_in),
	.Instruccion(mem_inst)

);

IF Buffer_IF(
	.clk(clk),
	.reset(reset),
	.A(Add),
	.B(mem_inst),
	.C(Add_ID),
	.D(mem_inst_ID)
	);
	
AND duv_inst(
	.A(Branch_to_AND),
	.B(Zero_to_AND),
	.S(AND_To_Sel)
);
	


U_Control UC (
	.OpCode(mem_inst_ID[31:26]),
	.RegDst(RegDst_to_Mux),
	.Branch(Branch_to_AND),
    .BR_En(BR_enabler),
    .AluC(AluOp),    // Cambiamos ALUCtrl a AluOp
    .EnW(MemW),
    .EnR(MemR),
    .Mux1(Mem_to_BR),
	.Jump(Jump),
	.ALUSrc(ALUSrc_to_Mux)
);

// Añadir el módulo ALUControl para convertir AluOp y FuncCode en ALUCtrl
ALUControl AC (
    .AluOp(AluOp),
    .FuncCode(mem_inst[5:0]), // Campo funct de instrucciones tipo R
    .ALUCtrl(ALUCtrl)
);
MuxBR duv_MBR(
	.sel(RegDst_to_Mux),
	.A(mem_inst_ID[20:16]),
	.B(mem_inst_ID[15:11]),
	.C(Mux_to_BR)
);

BR instBanco (
    .AR1(mem_inst_ID[25:21]),
    .AR2(mem_inst_ID[20:16]),
    .DE(WriteReg_WB),
    .DatoIn(DatoMem2BR),
    .RegWrite(BR_enabler_WB),
	.clk(clk),
    .DR11(d1BR_op1Alu),
    .Dr22(d2BR_op2Alu)
);

Sign_Extend Sign_inst(
	.in(mem_inst_ID[15:0]),
	.out(Sign_to_Shift)
);
ID_EX_Buffer Buffer_ID_EX (
    .clk(clk), 
	.reset(reset),
    .BR_En_in(BR_enabler), 
	.Mem_to_BR_in(Mem_to_BR),
    .Branch_in(Branch_to_AND), 
	.MemW_in(MemW), 
	.MemR_in(MemR),
    .RegDst_in(RegDst_to_Mux), 
	.ALUSrc_in(ALUSrc_to_Mux), 
	.AluOp_in(AluOp),
    .PC_Plus4_in(Add_ID), 
	.Dato1_in(d1BR_op1Alu), 
	.Dato2_in(d2BR_op2Alu), 
	.SignExt_in(Sign_to_Shift),
    .Rt_in(mem_inst_ID[20:16]), 
	.Rd_in(mem_inst_ID[15:11]), 
	.Funct_in(mem_inst_ID[5:0]),
	.BR_En_out(BR_enabler_EX), 
	.Mem_to_BR_out(Mem_to_BR_EX),
    .Branch_out(Branch_EX), 
	.MemW_out(MemW_EX), 
	.MemR_out(MemR_EX),
    .RegDst_out(RegDst_EX), 
	.ALUSrc_out(ALUSrc_EX), 
	.AluOp_out(AluOp_EX),
    .PC_Plus4_out(Add_EX), 
	.Dato1_out(d1BR_EX), 
	.Dato2_out(d2BR_EX), 
	.SignExt_out(Sign_EX),
    .Rt_out(Rt_EX), 
	.Rd_out(Rd_EX), 
	.Funct_out(Funct_EX)
);

Shift_left_2 duv_shift(
		.in(Sign_EX),
		.out(Shift_AddALU)
);

Add_ALURes uut_AddALU(
	.A(Add_EX),
	.B(Shift_AddALU),
	.Res(AddALU_to_Mux)
);

MuxALU MXALU(
	.sel(ALUSrc_EX),
	.A(d2BR_EX),
	.B(Sign_EX),
	.C(Mux_to_ALU)
);

ALU instALU (
    .Ope1(d1BR_EX),
    .Ope2(Mux_to_ALU),
    .AluOp(ALUCtrl),   // Aquí usamos ALUCtrl generado por ALUControl
    .Resultado(ResAlu),
	.zero_flag(Zero_to_AND)
);

EX_MEM_Buffer Buffer_EX_MEM (
    .clk(clk), 
	.reset(reset),
    .RegWrite_in(BR_enabler_EX), 
	.MemToReg_in(Mem_to_BR_EX),
    .MemRead_in(MemR_EX), 
	.MemWrite_in(MemW_EX), 
	.Branch_in(Branch_EX),
    .Zero_in(Zero_to_AND), 
	.ALU_Result_in(ResAlu), 
	.StoreData_in(d2BR_EX), 
	.WriteReg_in(Mux_to_BR),
    .RegWrite_out(BR_enabler_MEM), 
	.MemToReg_out(Mem_to_BR_MEM),
    .MemRead_out(MemR_MEM), 
	.MemWrite_out(MemW_MEM), 
	.Branch_out(Branch_MEM),
    .Zero_out(Zero_MEM), 
	.ALU_Result_out(ResAlu_MEM), 
	.StoreData_out(d2BR_MEM), 
	.WriteReg_out(WriteReg_MEM)
);

RAM duv_mem(
	.Datoin(d2BR_MEM),
	.Dir(ResAlu_MEM [4:0]),
	.WE(MemW_MEM),
	.RE(MemR_MEM),
	.clk(clk),
	.Datoout(MemD)
);

MEM_WB_Buffer Buffer_MEM_WB (
    .clk(clk), 
	.reset(reset),
    .RegWrite_in(BR_enabler_MEM), 
	.MemToReg_in(Mem_to_BR_MEM),
    .ReadData_in(MemD), 
	.ALU_Result_in(ResAlu_MEM), 
	.WriteReg_in(WriteReg_MEM),
    .RegWrite_out(BR_enabler_WB), 
	.MemToReg_out(Mem_to_BR_WB),
    .ReadData_out(MemD_WB), 
	.ALU_Result_out(ResAlu_WB), 
	.WriteReg_out(WriteReg_WB)
);
mux2_1 mux1 (
    .sel(Mem_to_BR_WB),
    .A(MemD_WB),
    .B(ResAlu_WB),
    .C(DatoMem2BR)
);

endmodule

