`timescale 1ns / 100ps
`include "./Defintions.v"

module forwarding(
	input clk,
	input [5:0] instruction,
	output reg muxA,
	output reg muxB
	);

reg first_instructionA, first_instructionB;

initial
	begin
		muxA = 0;
		muxB = 0;
		first_instructionA = 0;
		first_instructionB = 0;
	end

always @(clk)
	begin
		case(instruction)
		`LDA,`STA, `ADDA, `ADDCA, `ANDA, `ANDCA, `ORA, `LDCA, `LDA, `ASLA, `ASRA, `SUBA, `SUBCA, `ORCA:
			if(!first_instructionA)
			begin
				muxA = 0;
				muxB = 0;
				first_instructionA = 1;
				first_instructionB = 0;
			end
			else if(first_instructionA)
			begin
				muxA = 1;
				muxB = 0;
				first_instructionA = 1;
				first_instructionB = 0;
			end
		`LDB,`STB, `ADDB, `ADDCB, `ANDB, `ANDCB, `ORB, `LDCB, `LDB, `SUBB, `SUBCB, `ORCB:
			if(!first_instructionB)
			begin
				muxA = 0;
				muxB = 0;
				first_instructionA = 0;
				first_instructionB = 1;
			end
			else if(first_instructionB)
			begin
				muxA = 0;
				muxB = 1;
				first_instructionA = 0;
				first_instructionB = 1;
			end
		default:
			begin
				muxA = 0;
				muxB = 0;
				first_instructionA = 0;
				first_instructionB = 0;
			end
		endcase
	end



endmodule
