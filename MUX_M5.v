module mu5(
	input [4:0]A,
	input [4:0]B,
	input sel,
	output reg [4:0] S
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
