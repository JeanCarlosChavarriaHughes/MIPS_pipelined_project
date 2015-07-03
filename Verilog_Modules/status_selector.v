`include "../Verilog_Modules/Defintions.v"

module status_selector(
	input [5:0] instruction,
	input [7:0] regA, regB,
	input zero,
	input carry,
	input sign,
	output reg CA, CB, ZA, ZB, NA, NB
	);

initial 
	begin
		CA = 0;
		CB = 0;
		NA = 0;
		NB = 0;
		ZA = 0;
		ZB = 0;
	end

always @(instruction or zero or carry or sign)
	begin
		case(instruction)
		
		`ADDA, `ADDCA, `ANDA, `ANDCA, `ORA, `ASLA, `ASRA, `SUBA, `SUBCA, `ORCA:
			begin
				CA = carry;
				ZA = zero;
				NA = sign;
			end
		`ADDB, `ADDCB, `ANDB, `ANDCB, `ORB, `SUBB, `SUBCB, `ORCB:
			begin 
				CB = carry;
				ZB = zero;
				NB = sign;
			end
		`LDA, `LDCA:
			begin
				ZA = ~|regA;
				NA = regA[7];
			end
		`LDB,  `LDCB:
			begin
				ZB = ~|regB;
				NB = regB[7];
			end
		default:
			CA = CA;
		endcase
	end


endmodule
