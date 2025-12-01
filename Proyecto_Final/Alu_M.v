`timescale 1ns/1ns

module ALU(
	input [31:0] Ope1,
	input [31:0] Ope2,
	input [2:0] AluOp,
	output reg [31:0] Resultado,
	output reg zero_flag
);
	
	always @(*)
	begin
		case (AluOp)
			3'b000: // AND
				Resultado = Ope1 & Ope2;
			
			3'b001: // OR
				Resultado = Ope1 | Ope2;
			
			3'b010: // ADD (LW, SW, ADDI, ADD)
				Resultado = Ope1 + Ope2;
			
			3'b011: // XOR
				Resultado = Ope1 ^ Ope2;
			
			3'b100: // NOR
				Resultado = ~(Ope1 | Ope2);
			
			3'b110: // SUB (BEQ, SUB)
				Resultado = Ope1 - Ope2;
			
			3'b111: // SLT 
			begin
				// Usamos $signed() para que Verilog entienda comparacion de negativos
				if ($signed(Ope1) < $signed(Ope2))
					Resultado = 32'd1;
				else
					Resultado = 32'd0;
			end
			
			default: 
				Resultado = 32'd0;
		endcase
		
		// Calculamos el flag fuera del case para ahorrar líneas repetidas
		zero_flag = (Resultado == 32'd0);
	end
endmodule
