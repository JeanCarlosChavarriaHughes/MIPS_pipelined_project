`include "./../Verilog_Modules/branch_taken.v"
`timescale 1ns/100ps

module branch_taken_tester(
	output reg [3:0] branch_taken,	// Valor del branch taken proveniente del instruction decoder
	output reg ZA,					// Bandera de cero para el registro A.
	output reg ZB,					// Bandera de cero para el registro B.
	output reg NA,					// Bandera de signo para el registro A.
	output reg NB,					// Bandera de signo para el registro B.
	output reg CA,					// Bandera de acarreo para el registro A.
	output reg CB,					// Bandera de acarreo para el registro B.
	input taken						// Indica si el branch se toma o no.
	);
	 
	
	initial
		begin
			$dumpfile("branch_taken.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"branch: ",branch_taken,,"ZA: %b",ZA,," NA: %b", NA,," CA: %b", CA,,"ZB: %b",ZB,," NB: %b", NB,," CB: %b", CB,," taken: ",taken);
		end		
	initial
		begin
			// branch 1 -> BAEQ
			branch_taken = 4'd1;
			// ZA = 0
			ZA = 0;
			// ZA = 1
			#200 ZA = 1;
			// branch 2 -> BANE
			#200 branch_taken = 4'd2;
			// ZA = 0
			ZA = 0;
			// ZA = 1
			#200 ZA = 1;
			// branch 3 -> BACS
			#200 branch_taken = 4'd3;
			// CA = 0
			CA = 0;
			// CA = 1
			#200 CA = 1;
			// branch 4 -> BACC
			#200 branch_taken = 4'd4;
			// CA = 0
			CA = 0;
			// CA = 1
			#200 CA = 1;
			// branch 5 -> BAMI
			#200 branch_taken = 4'd5;
			// NA = 0
			NA = 0;
			// NA = 1
			#200 NA = 1;
			// branch 6 -> BAPL
			#200 branch_taken = 4'd6;
			// NA = 0
			NA = 0;
			// NA = 1
			#200 NA = 1;
			// branch 7 -> BBEQ
			#200 branch_taken = 4'd7;
			// ZB = 0
			ZB = 0;
			// ZB = 1
			#200 ZB = 1;
			// branch 8 -> BBNE
			#200 branch_taken = 4'd8;
			// ZB = 0
			ZB = 0;
			// ZB = 1
			#200 ZB = 1;
			// branch 9 -> BBCS
			#200 branch_taken = 4'd9;
			// CB = 0
			CB = 0;
			// CB = 1
			#200 CB = 1;
			// branch 10 -> BBCC
			#200 branch_taken = 4'd10;
			// CB = 0
			CB = 0;
			// CB = 1
			#200 CB = 1;
			// branch 11 -> BBMI
			#200 branch_taken = 4'd11;
			// NB = 0
			NB = 0;
			// NB = 1
			#200 NB = 1;
			// branch 12 -> BBPL
			#200 branch_taken = 4'd12;
			// NB = 0
			NB = 0;
			// NB = 1
			#200 NB = 1;
			
			#200 $finish;
		end
			
	
endmodule

module TestBench;
	wire [3:0] branch_taken;	// Valor del branch taken proveniente del instruction decoder
	wire ZA;					// Bandera de cero para el registro A.
	wire ZB;					// Bandera de cero para el registro B.
	wire NA;					// Bandera de signo para el registro A.
	wire NB;					// Bandera de signo para el registro B.
	wire CA;					// Bandera de acarreo para el registro A.
	wire CB;					// Bandera de acarreo para el registro B.
	wire taken;					// Indica si el branch se toma o no.
	
	branch_taken_tester Test1(branch_taken,
						      ZA,
						      ZB,
						      NA,
						      NB,
						      CA,
						      CB,
						      taken);
						
	branch_taken Taken(branch_taken,
						      ZA,
						      ZB,
						      NA,
						      NB,
						      CA,
						      CB,
						      taken);
	
	
	
endmodule


