//1.Definicion del modulo y sus I/O
//Dentro del parentesis se define los I/O
module _compuertas(input a, input b, output c_and,  output c_nand, output c_or, output c_nor,output c_not, output c_xor,output c_xnor);
//2.Definen cables o componentes internos
//NA
//3.Asignaciones, instancias, conexiones

assign c_and = a & b;
assign c_nand = ~(a & b);
assign c_or = a | b;
assign c_nor = ~(a | b);
assign c_not = ~a;
assign c_xor = a ^ b;
assign c_xnor = ~(a ^ b);


endmodule
