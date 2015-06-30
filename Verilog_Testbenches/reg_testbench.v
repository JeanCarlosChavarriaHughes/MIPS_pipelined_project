`include "./../Verilog_Modules/reg.v"
`include "./../Verilog_Modules/ffd.v"
`timescale 1ns/100ps

module reg_tester(
	
	input 				[7:0] data_written,
	output reg		[7:0]		data_result,
	output reg					select,
	output reg					clk
	);
	 
	
	initial
		begin
			$dumpfile("register.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"Input: %d",data_result,, "Output: %d", data_written);
		end		
	initial
		begin
			clk = 0;
			select = 0;
			data_result = 0;
		end
	
	initial
		begin
			repeat(13)
				begin
					#10 data_result = data_result + 1;
				end
				#10 $finish;
		end
		
	initial
		begin
			repeat(12)
				#30 select = ~select;
		end
	initial
		begin
			repeat(50)
				#5 clk = ~clk;
		end

endmodule

module TestBench;

	wire [7:0] data_written, data_result, data_result_AF;
	
	reg_tester tester1(data_written, data_result, select, clk);
	register regA(data_result_AF, select_AF, data_written);
	FFD_POSEDGE_SYNCRONOUS_RESET #8 ffd_1( clk, 0, 1'b1, data_result, data_result_AF);
	FFD_POSEDGE_SYNCRONOUS_RESET #1 ffd_2( clk, 0, 1'b1, select, select_AF);

endmodule


