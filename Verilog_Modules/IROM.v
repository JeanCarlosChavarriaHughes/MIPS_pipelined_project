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

	0: oInstruction = { `NOP , 10'd0    	};
	1: oInstruction = { `STA , 10'd231	 	};
	2: oInstruction = { `LDCB ,10'd0     	}; 
	3: oInstruction = { `ANDA, 10'd45		};
	4: oInstruction = { `SUBCB, 10'd0   	};
	5: oInstruction = { `JMP ,10'd0 		};
	6: oInstruction = { `BANE ,10'd0     	};
	 	
	7: oInstruction = { `BACC ,10'd0		};
	8: oInstruction = { `BBNE ,10'd0		}; 
	9: oInstruction = { `BBCC ,10'd0		}; 
	10: oInstruction = { `BBPL ,10'd0		};
	11: oInstruction = { `SUBB ,10'd0		};	
	12: oInstruction = { `STB ,10'd0		}; 
	
	default:
		oInstruction = { `NOP ,  10'd0 		};		//NOP
	endcase	
end
	
endmodule
