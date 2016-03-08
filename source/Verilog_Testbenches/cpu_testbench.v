`include "./../Verilog_Modules/cpu.v"
//`include "./../Verilog_Modules/ffd.v"
`timescale 1ns/100ps

module cpu_tester(
	
	input [7:0] 				a,
	input [7:0]					b,
	output reg					clk,
	output reg					reset
	);
	 
	
	initial
		begin
			$dumpfile("cpu.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"Valor de A: %h",a,, "Valor de B: %h", b);
			#2200 $finish;
		end		
	initial
		begin
			clk = 0;
		end
	
	
	initial
		begin
			reset = 0;
			#20 reset = 1;
			#100 reset = 0;
		end
	initial
		begin
			repeat(200)
				#10 clk = ~clk;
		end

endmodule

module TestBench;

	wire [7:0] a, b;
	wire clk, reset;
	
	cpu_tester tester1(a, b, clk, reset);
	cpu pipeline1(clk, reset, a, b);

endmodule


