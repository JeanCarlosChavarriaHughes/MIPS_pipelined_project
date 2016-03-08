`timescale 1ns / 1ps
module branch_calc(
	input wire [9:0] pc_in,     // Salida del program counter
	input wire [15:0] const,    // Salida del instruction decoder
	output reg [9:0] branch     // Branch
	);
	
	wire [9:0] value_branch;	// Se utilizara para almacenar el valor del branch.
	wire bit;					// Se utilizara para almacenar el valor del setimo bit menos significativo.
	
	// Lee el setimo bit menos significativo.
	assign bit = const[6];
	
	// Lee los seis bits menos significativos.
	assign value_branch = {4'b0,const[5:0]};
	
	// Revisa si el setimo bit menos significativo esta en 0 o en 1.
	always @(*)
	begin
		if (bit == 0)	// Si esta en 0, los 6 bits menos significativos de const deben sumarse al pc.
		
			branch = value_branch + pc_in;
				
		else			// Si esta en 1, los 6 bits menos significativos de const deben restarse al pc.
		
			branch = pc_in - value_branch;

	end

endmodule
		
