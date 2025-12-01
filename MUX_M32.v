module mul32(
	input [31:0]A,
	input [31:0]B,
	input sel,
	output reg [31:0]S
);


always @*
	begin
		if(sel == 0)begin
			S= A;
		end else begin
			S = B;
		end
	end 

endmodule 
