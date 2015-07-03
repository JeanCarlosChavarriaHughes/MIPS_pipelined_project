`timescale 1ns / 100ps
`include "./../Verilog_Modules/Defintions.v"


module instruction_rom
	(
	input  wire[9:0]  		iAddress,
	output reg [15:0] 		oInstruction
	);	
	
always @ ( iAddress )
begin
	case (iAddress)

	0: oInstruction = { `ADDA , 10'd2    };
	1: oInstruction = { `LDA , 10'd0 };
	2: oInstruction = { `NOP ,10'd16     }; 
	3: oInstruction = { `NOP, 10'd8};
	4: oInstruction = { `NOP, 10'd0   };
	5: oInstruction = { `LDCA ,10'd8 };
	6: oInstruction = { `LDCB ,10'd1     };
	 	
	7: oInstruction = { `ORB ,10'd0};
	8: oInstruction = { `ADDB ,10'd1000};
	9: oInstruction = { `SUBA ,10'd0}; 
	10: oInstruction = { `NOP ,10'd3};
	11: oInstruction = { `NOP ,10'd0};
	12: oInstruction = { `ANDA, 10'd1000  }; 
	13: oInstruction = { `NOP ,10'd0};
	14: oInstruction = { `SUBA ,10'd0}; 
	15: oInstruction = { `NOP ,10'd0};
	16: oInstruction = { `LDB ,10'd0}; 
	17: oInstruction = { `NOP ,10'd0};
	18: oInstruction = { `JMP, 10'd1000  }; 
	19: oInstruction = { `NOP ,10'd0};
	20: oInstruction = { `NOP ,10'd0}; 
	21: oInstruction = { `NOP ,10'd0};
	22: oInstruction = { `LDB ,10'd0}; 
	23: oInstruction = { `NOP ,10'd0};
	24: oInstruction = { `JMP, 10'd1000  }; 
	25: oInstruction = { `NOP ,10'd0};
	26: oInstruction = { `NOP ,10'd0}; 
	27: oInstruction = { `NOP ,10'd0};
	28: oInstruction = { `LDB ,10'd0}; 
	29: oInstruction = { `NOP ,10'd0};
	30: oInstruction = { `JMP ,10'd14};
	
	default:
		oInstruction = { `NOP ,  10'd0 		};		//NOP
	endcase	
end
	
endmodule
