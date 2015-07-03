`include "./../Verilog_Modules/forwarding_unit.v"
`include "./../Verilog_Modules/instruction_rom_forward.v"
`include "./../Verilog_Modules/ffd.v"
`include "./../Verilog_Modules/Defintions.v"
`timescale 1ns/100ps

module decode_tester(
	
	input outputA_EX,
	input outputA_MEM,
	input outputB_EX,
	input outputB_MEM,
	output reg		[9:0]		pc,
	output reg					clk
	);
	 
	
	initial
		begin
			$dumpfile("forward.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"PC: %d",pc,,"OutputA_EX: ", outputA_EX,, "OutputA_MEM: ", outputA_MEM,, "OutputB_EX: ", outputB_EX,, "OutputB_MEM: ", outputB_MEM,, );
		end		
	initial
		begin
			clk = 1;
			pc = 0;
		end
	
	initial
		begin
			repeat(16)
				begin
					#20 pc = pc + 1;
				end
				#20 $finish;
		end
	initial
		begin
			repeat(50)
				#10 clk = ~clk;
		end

endmodule

module TestBench;


	wire [9:0] pc;
	wire [9:0] iAddress;
	wire [15:0] oInstruction;
	wire [5:0] instruction_EX, instruction_MEM;
	wire outputA_EX, outputA_MEM, outputB_EX, outputB_MEM;
	wire clk;
	
	decode_tester Test1(outputA_EX,
						outputA_MEM,
						outputB_EX,
						outputB_MEM,
						pc,
						clk);
						
	instruction_rom Mem(iAddress,
						oInstruction);
	
	
					
	forwarding unit1(clk,
					oInstruction[15:10],
					instruction_EX,
					instruction_MEM,
					outputA_EX,
					outputA_MEM,
					outputB_EX,
					outputB_MEM);

	FFD_POSEDGE_SYNCRONOUS_RESET #6 ff1( clk, 1'b0, 1'b1, oInstruction[15:10], instruction_EX);
	FFD_POSEDGE_SYNCRONOUS_RESET #6 ff2( clk, 1'b0, 1'b1, instruction_EX, instruction_MEM);
	assign iAddress = pc;						

endmodule


