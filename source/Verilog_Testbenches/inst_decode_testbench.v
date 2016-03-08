`include "./../Verilog_Modules/instruction_decoder.v"
`include "./../Verilog_Modules/instruction_rom.v"
`include "./../Verilog_Modules/ffd.v"
`timescale 1ns/100ps

module decode_tester(
	
	input wire [9:0] const,
	input write_to_a, //Salida en alto si la instrucción escribe en el registro A
	input write_to_b, //Salida en alto si la instrucción escribe en el registro A
	input mux_pre_alu_a,//Salida en bajo si se elige enviar a la ALU el contenido del registro A
	input mux_pre_alu_b,//Salida en bajo si se elige enviar a la ALU el contenido del registro B
	input read_write,	//Salida en alto si se va a hacer una escritura en la memoria. Bajo para lectura
	input write_back_mux,//Salida en alto para tomar el dato al que se va a hacer write back de la salida de la memoria. Bajo para que sea la salida de la ALU
	input [1:0] write_mux,
	input jump,
	input [3:0] branch_taken,
	input [15:0] inst,
	output reg		[9:0]		pc,
	output reg					clk
	);
	 
	
	initial
		begin
			$dumpfile("decoder.vcd");
			$dumpvars;
			$display("Time Diagram");
			$monitor("t=",$time,,"PC: %d",pc,, "Instruccion: $%h", inst[15:10]);
		end		
	initial
		begin
			clk = 0;
			pc = 0;
		end
	
	initial
		begin
			repeat(13)
				begin
					#2 pc = pc + 1;
				end
				#2 $finish;
		end
	initial
		begin
			repeat(50)
				#1 clk = ~clk;
		end

endmodule

module TestBench;

	wire [1:0] write_mux;
	wire [9:0] const;
	wire [3:0] branch_taken;
	wire [9:0] pc;
	wire [9:0] iAddress;
	wire [15:0] oInstruction;
	wire [15:0] inst;
	wire write_to_a, write_to_b, mux_pre_alu_a, mux_pre_alu_b, read_write, write_back_mux, jump;
	wire clk;
	
	decode_tester Test1(const, 
						write_to_a,
						write_to_b,
						mux_pre_alu_a,
						mux_pre_alu_b,
						read_write,
						write_back_mux,
						write_mux,
						jump,
						branch_taken,
						oInstruction,
						pc,
						clk);
						
	instruction_rom Mem(iAddress,
						oInstruction);
						
	inst_decoder Decoder(inst,
						const,
						write_to_a,
						write_to_b,
						mux_pre_alu_a,
						mux_pre_alu_b,
						read_write,
						write_back_mux,
						write_mux,
						jump,
						branch_taken);
	assign iAddress = pc;						
	//FFD_POSEDGE_SYNCRONOUS_RESET #10 ffd_1( clk, 0, 1, pc, iAddress);
	FFD_POSEDGE_SYNCRONOUS_RESET #16 ffd_2( clk, 0, 1, oInstruction, inst);

endmodule


