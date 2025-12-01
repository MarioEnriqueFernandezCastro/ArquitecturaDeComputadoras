module IF(
	input clk,
	input reset,
	input [31:0] A,
	input [31:0] B,
	output reg [31:0]C,
	output reg [31:0]D
	);
	

	always @(posedge clk or posedge reset)
		begin
			if(reset) begin
				C <= 32'b00;
				D <= 32'b00;
			end else begin
				C<=A;
				D<=B;
				end
		end

endmodule
