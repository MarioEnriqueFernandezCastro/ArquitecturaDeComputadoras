`timescale 1ns/1ns

module mux2_1(
    input sel,
    input [31:0] A,
    input [31:0] B,
    output [31:0] C
);

   
    assign C = (sel == 1'b1) ? A : B;

endmodule
