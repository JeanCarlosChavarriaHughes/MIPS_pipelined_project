`timescale 1ns / 100ps
`include "./../Verilog_Modules/Defintions.v"


module forwarding(
	input clk,
	input [5:0] instruction_ID,
	input [5:0] instruction_EX,
	input [5:0] instruction_MEM,
	output reg outputA_EX, outputA_MEM,
	output reg outputB_EX, outputB_MEM
	);

reg first_instructionA, first_instructionB;

initial
	begin
		outputA_EX = 0;
		outputB_EX = 0;
		outputA_MEM = 0;
		outputB_MEM = 0;
	end

always @(posedge clk)
	begin
		if (instruction_ID == `STA || instruction_ID == `ADDA || instruction_ID == `ADDB || instruction_ID == `ADDCA || instruction_ID == `SUBA || instruction_ID == `SUBB || instruction_ID == `SUBCA || instruction_ID == `ANDA || instruction_ID == `ANDB || instruction_ID == `ANDCA || instruction_ID == `ORA || instruction_ID == `ORB || instruction_ID == `ORCA || instruction_ID == `ASLA || instruction_ID == `ASRA)
			begin
				if (instruction_EX == `LDA || instruction_EX == `LDA || instruction_EX == `LDCA || instruction_EX == `ADDA || instruction_EX == `ADDCA || instruction_EX == `SUBA || instruction_EX == `SUBCA || instruction_EX == `ANDA || instruction_EX == `ANDCA || instruction_EX == `ORA || instruction_EX == `ORCA || instruction_EX == `ASLA || instruction_EX == `ASRA)
					begin
						outputA_EX = 1;
					end
				else
					begin
						outputA_EX = 0;
					end

				if (instruction_MEM == `LDA || instruction_MEM == `LDA || instruction_MEM == `LDCA || instruction_MEM == `ADDA || instruction_MEM == `ADDCA || instruction_MEM == `SUBA || instruction_MEM == `SUBCA || instruction_MEM == `ANDA || instruction_MEM == `ANDCA || instruction_MEM == `ORA || instruction_MEM == `ORCA || instruction_MEM == `ASLA || instruction_MEM == `ASRA)
					begin
						outputA_MEM = 1;
					end
				else
					begin
						outputA_MEM = 0;
					end
			end
		else begin
			outputA_EX = 0;
			outputA_MEM = 0;
		end

		if (instruction_ID == `STB || instruction_ID == `ADDA || instruction_ID == `ADDB || instruction_ID == `ADDCB || instruction_ID == `SUBA || instruction_ID == `SUBB || instruction_ID == `SUBCB || instruction_ID == `ANDA || instruction_ID == `ANDB || instruction_ID == `ANDCB || instruction_ID == `ORA || instruction_ID == `ORB || instruction_ID == `ORCB)
			begin
				if (instruction_EX == `LDB || instruction_EX == `LDCB || instruction_EX == `ADDB || instruction_EX == `ADDCB || instruction_EX == `SUBB || instruction_EX == `SUBCB || instruction_EX == `ANDB || instruction_EX == `ANDCB || instruction_EX == `ORB || instruction_EX == `ORCB)
					begin
						outputB_EX = 1;
					end
				else
					begin
						outputB_EX = 0;
					end

				if (instruction_MEM == `LDB || instruction_MEM == `LDCB || instruction_MEM == `ADDB || instruction_MEM == `ADDCB || instruction_MEM == `SUBB || instruction_MEM == `SUBCB || instruction_MEM == `ANDB || instruction_MEM == `ANDCB || instruction_MEM == `ORB || instruction_MEM == `ORCB)
					begin
						outputB_MEM = 1;
					end
				else
					begin
						outputB_MEM = 0;
					end
			end
		else begin
				outputB_MEM = 0;
				outputB_EX = 0;
		end
	end
endmodule
