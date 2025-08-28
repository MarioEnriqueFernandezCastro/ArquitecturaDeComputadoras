`timescale 1ns/1ns
//1.Definicion del modulo I/O
module Cuasi(
	input [3:0]a,
	input [3:0]b,
	input sel,
	output reg [3:0]c  //por que se le asigna su valor dentro del always.
);
//2.Def de componentes internos

//assigns, intancias, bloques secuenciales: initial y always.
//registros solo se pueden usar cambiar modificar dentro de bloques secuenciales intial y always 
always @*
begin
	case(sel)
			1'b0:
				begin
				c = a + b;
				end
			1'b1:
				begin
				c = a & b;
				end
		endcase
end
endmodule
