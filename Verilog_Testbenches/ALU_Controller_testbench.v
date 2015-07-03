`include "./../Verilog_Modules/alu_control.v"
`timescale 1ns/100ps

module TestBench;

	wire [5:0] iInstruction_wire;
	wire [2:0] oAluctl_reg;

	alu_control__Tester Test1(iInstruction_wire,oAluctl_reg);
	alu_control alu_control1(iInstruction_wire,oAluctl_reg);

endmodule

module alu_control__Tester(iInstruction_wire,oAluctl_reg);

	output reg [5:0]	iInstruction_wire;
	input wire [2:0]	oAluctl_reg;

	initial
		begin
			$dumpfile("alu_controller.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"iInstruction %o",iInstruction_wire," -> ","oAluctl_reg %o",oAluctl_reg);
				iInstruction_wire = 6'd0;
				#2 iInstruction_wire = 6'd1;
				#2 iInstruction_wire = 6'd2;
				#2 iInstruction_wire = 6'd3;
				#2 iInstruction_wire = 6'd4;
				#2 iInstruction_wire = 6'd5;
				#2 iInstruction_wire = 6'd6;
				#2 iInstruction_wire = 6'd7;
				#2 iInstruction_wire = 6'd8;
				#2 iInstruction_wire = 6'd9;
				#2 iInstruction_wire = 6'd10;
				#2 iInstruction_wire = 6'd11;
				#2 iInstruction_wire = 6'd12;
				#2 iInstruction_wire = 6'd13;
				#2 iInstruction_wire = 6'd14;
				#2 iInstruction_wire = 6'd15;
				#2 iInstruction_wire = 6'd16;
				#2 iInstruction_wire = 6'd17;
				#2 iInstruction_wire = 6'd18;
				#2 iInstruction_wire = 6'd19;
				#2 iInstruction_wire = 6'd20;
				#2 iInstruction_wire = 6'd21;
				#2 iInstruction_wire = 6'd22;
				#2 iInstruction_wire = 6'd23;
				#2 iInstruction_wire = 6'd24;
				#2 iInstruction_wire = 6'd25;
				#2 iInstruction_wire = 6'd26;
				#2 iInstruction_wire = 6'd27;
				#2 iInstruction_wire = 6'd28;
				#2 iInstruction_wire = 6'd29;
				#2 iInstruction_wire = 6'd30;
				#2 iInstruction_wire = 6'd31;
				#2 iInstruction_wire = 6'd32;
				#2 iInstruction_wire = 6'd33;
				#2 iInstruction_wire = 6'd34;
				#2 iInstruction_wire = 6'd35;
				#2 iInstruction_wire = 6'd36;
				#2 iInstruction_wire = 6'd37;
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



