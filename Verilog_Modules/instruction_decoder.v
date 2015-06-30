`timescale 1ns / 1ps
`include "./Defintions.v"

module inst_decoder(
	
	input wire [15:0] inst, //Entrada con la instruccion obtenida de la ROM
	output wire [15:0] const, //Salida con los 10 LSB de la instrucción. Usos varios
	output reg write_to_a, //Salida en alto si la instrucción escribe en el registro A
	output reg write_to_b, //Salida en alto si la instrucción escribe en el registro A
	output reg mux_pre_alu_a,//Salida en bajo si se elige enviar a la ALU el contenido del registro A
	output reg mux_pre_alu_b,//Salida en bajo si se elige enviar a la ALU el contenido del registro B
	output reg read_write,	//Salida en alto si se va a hacer una escritura en la memoria. Bajo para lectura
	output reg write_back_mux,//Salida en alto para tomar el dato al que se va a hacer write back de la salida de la memoria. Bajo para que sea la salida de la ALU
	output reg [1:0] write_mux,
	output reg jump,
	output reg [3:0] branch_taken
	);

	assign const = inst[15:0];
	
	always @(inst)
	begin
		case (inst[15:10])
			`LDA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 1;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`LDB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 1;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`LDCA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`LDCB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`STA:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 1;
				read_write = 1;
				write_back_mux = 0;
				write_mux = 1;
				jump = 0;
				branch_taken = 0;
			end
			
			`STB:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 0;
				read_write = 1;
				write_back_mux = 0;
				write_mux = 2;
				jump = 0;
				branch_taken = 0;
			end
			
			`ADDA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ADDB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ADDCA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ADDCB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`SUBA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`SUBB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`SUBCA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`SUBCB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ANDA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ANDB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ANDCA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ANDCB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ORA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ORB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ORCA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 1;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ORCB:
			begin
				write_to_a = 0;
				write_to_b = 1;
				mux_pre_alu_a = 1;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ASLA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			`ASRA:
			begin
				write_to_a = 1;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 0;
			end
			
			
			
			`JMP:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 1;
				branch_taken = 0;
			end
			
			`BAEQ:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 1;
			end
			
			`BANE:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 2;
			end
			`BACS:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 3;
			end
			`BACC:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 4;
			end
			`BAMI:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 5;
			end
			`BAPL:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 6;
			end
			`BBEQ:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 7;
			end
			`BBNE:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 8;
			end
			`BBCS:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 9;
			end
			`BBCC:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 10;
			end
			`BBMI:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 11;
			end
			`BBPL:
			begin
				write_to_a = 0;
				write_to_b = 0;
				mux_pre_alu_a = 0;
				mux_pre_alu_b = 0;
				read_write = 0;
				write_back_mux = 0;
				write_mux = 0;
				jump = 0;
				branch_taken = 12;
			end
		endcase
	end

endmodule
