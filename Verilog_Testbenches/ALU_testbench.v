`include "./../Verilog_Modules/alu.v"
`timescale 1ns/100ps

module TestBench;

	parameter SIZE = 9;

	wire [SIZE:0] in1, in2, out;
	wire [2:0] ctl;
	wire zero, carry_out;

	alu__Tester Test1(ctl,in1,in2,out,carry_out,zero);
	alu alu_1(ctl,in1,in2,out,carry_out,zero);

endmodule



module alu__Tester(ctl,in1,in2,out,carry_out,zero);

	output reg		[2:0]		ctl;
	output reg		[SIZE:0]	in1; 
	output reg		[SIZE:0]	in2;
	input 			[SIZE:0]	out;
	input						carry_out;
	input						zero;

	parameter SIZE = 9;

	initial
		begin
			$dumpfile("alu.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"control %o",ctl,,,"Result: %d",out," -> "," in1 %d",in1,," in2 %d",in2);
				ctl = 3'b000;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;

				#2 ctl = 3'b001;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;				
				
				#2 ctl = 3'b011;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;

				#2 ctl = 3'b010;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;

				#2 ctl = 3'b101;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;

				#2 ctl = 3'b100;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;

				#2 ctl = 3'b110;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;

				#2 ctl = 3'b111;
				#2 in1 = 10'd512;
				in2 = 10'd256;
				#2 in1 = 10'd768;
				in2 = 10'd128;

				#2 ctl = 3'b001;
				#2 in1 = 10'd512;
				in2 = 10'd513;
				#2 in1 = 10'd512;
				in2 = 10'd512;
				#2 in1 = 10'd512;
				in2 = 10'd511;

				#2 $finish;
		end
/*
*				genvar index;  
*				generate  
*					for (index=0; index < 38; index=index+1)  
*				    	begin: code_instructions_generations  
*					    	#2 iInstruction = 6'd(index);
*					    	);  
*					  	end  
*				endgenerate  
*
*					#8 $finish;
*				end
*/

endmodule



