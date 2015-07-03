`include "./../Verilog_Modules/data_ram.v"
`timescale 1ns/100ps

module memory_tester (Enable, ReadWrite, Address, DataIn, DataOut);
	
	output reg Enable, ReadWrite;
	output reg [7: 0] DataIn;
	output reg [9: 0] Address;
	input [7: 0] DataOut;
	

	initial
		begin
			$dumpfile("ram.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"Input: %d",DataIn,, "Output: %d", DataOut,, "Address: %d", Address );
		end		
	initial
		begin
			ReadWrite = 1;
			Enable = 1;
			DataIn = 15;
			Address = 0;
		end
	
	initial
		begin
			repeat(1024)
				begin
					#10 DataIn = DataIn + 1;
					Address = Address + 1;
				end
				ReadWrite = 0;
			repeat(1024)
				begin
					#10 DataIn = DataIn + 1;
					Address = Address + 1;
				end
				#10 $finish;
		end
	

endmodule

module TestBench;

	wire Enable, ReadWrite;
	wire [7:0] DataIn, DataOut;
	wire [9:0] Address;
	
	memory_tester MEM1_TEST(Enable,ReadWrite,Address,DataIn,DataOut);
	memory mem1(Enable,ReadWrite,Address,DataIn,DataOut);

endmodule


