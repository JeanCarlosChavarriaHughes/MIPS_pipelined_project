`include "./../Verilog_Modules/branch_calc.v"
`timescale 1ns/100ps

module branch_calc_tester(
	output reg [9:0] pc_in,     // Salida del program counter
	output reg [15:0] const,    // Salida del instruction decoder 7 menos significativos
	input [9:0] branch          // Valor del branch
	);
	 
	
	initial
		begin
			$dumpfile("branch_calc.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"PC: %d",pc_in,,"Bit: %b",const[6],," Const: %d", const[5:0],,"Branch: %d", branch[9:0]);
		end		
	initial
		begin
			pc_in = 10'd100;
			// test 1
			#200 const = {1'd1,6'd5};
			// test 2
			#200 const = {1'd0,6'd10};
			// test 36
			#200 const = {1'd1,6'd20};
			// test 4
			#200 const = {1'd0,6'd30};
			// termina
			#200 $finish;
		end
			
	
endmodule

module TestBench;
	wire [9:0] pc_in;
	wire [15:0] const;
	wire [9:0] branch;
	
	branch_calc_tester Test1(pc_in,
						const,
						branch);
						
	branch_calc Calc(pc_in,
					 const,
	                 branch);
	
	
	
endmodule


