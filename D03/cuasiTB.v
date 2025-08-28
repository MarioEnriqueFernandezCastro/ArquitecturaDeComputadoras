`timescale 1ns/1ns
//1.Def del modulo E/S
module Cuasi_TB();
//2.Def de componentes internos
reg [3:0]a_tb;
reg [3:0]b_tb;
reg [3:0]sel_tb;
wire [3:0]c_tb;
//instancias, assigns, bloques secuencias initials, always.
Cuasi DUV (
	.a(a_tb), 
	.b(b_tb), 
	.sel(sel_tb), 
	.c(c_tb)
);

initial
begin
//8+6,3+2,1+1,1+5,10+2
//8+6
a_tb = 4'd8;
b_tb = 4'd6;
sel_tb = 1'b0; 
	
#100;
//and
sel_tb = 1'b1; 
	
#100;
//3+2	
a_tb = 4'd3;
b_tb = 4'd2;
sel_tb = 1'b0; 
	
#100;
//and
sel_tb = 1'b1;  
	
#100;
//suma 1+1
a_tb = 4'd1;
b_tb = 4'd1;
sel_tb = 1'b0; 
	
#100;
//and	
sel_tb = 1'b1; 

#100;
//1+5
a_tb = 4'd1;
b_tb = 4'd5;
sel_tb = 1'b0;

#100;
//and
sel_tb = 1'b1;

#100;
//10+2
a_tb = 4'd10;
b_tb = 4'd2;
sel_tb = 1'b0;

#100;
//and
sel_tb = 1'b1;

#100;
	$stop;
end


endmodule
