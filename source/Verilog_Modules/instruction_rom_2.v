`timescale 1ns / 100ps
`include "./../Verilog_Modules/Defintions.v"

`define LOOP3 10'd26
`define LOOP5 10'd41
`define FINAL 10'd60

module instruction_rom
	(
	input  wire[9:0]  		iAddress,
	output reg [15:0] 		oInstruction
	);	
	
always @ ( iAddress )
begin
	case (iAddress)

	0: oInstruction =  { `NOP   , 10'b0000000000};
	1: oInstruction =  { `NOP   , 10'b0000000000};
	2: oInstruction =  { `NOP   , 10'b0000000000}; 
	3: oInstruction =  { `NOP   , 10'b0000000000};
	4: oInstruction =  { `NOP   , 10'b0000000000};
	5: oInstruction =  { `LDCA  , 10'b0001100100}; // Carga la constante 100 en A
	6: oInstruction =  { `LDCB  , 10'b0000000000}; // Carga la constante 0 en B
	7: oInstruction =  { `SUBCB , 10'b0101011110}; // Le resta a B la constante 350
	8: oInstruction =  { `NOP   , 10'b0000000000}; 
	9: oInstruction =  { `NOP   , 10'b0000000000}; 
//LOOP1
	10: oInstruction = { `ADDCB , 10'b0000001010}; // Le suma la constante 10 a B
	11: oInstruction = { `NOP   , 10'b0000000000}; 
	12: oInstruction = { `NOP   , 10'b0000000000}; 
	13: oInstruction = { `BBMI  , 4'd0,6'd5};      // Sigue en el siguiente ciclo (LOOP2)
	14: oInstruction = { `NOP   , 10'b0000000000};
	15: oInstruction = { `NOP   , 10'b0000000000};
	16: oInstruction = { `NOP   , 10'b0000000000};
	17: oInstruction = { `JMP   , `LOOP3};         // Salta a LOOP3
//LOOP2
	18: oInstruction = { `ADDB  , 10'b0000000000}; // Suma A con B y lo guarda en B
	19: oInstruction = { `NOP   , 10'b0000000000};
	20: oInstruction = { `NOP   , 10'b0000000000};
	21: oInstruction = { `NOP   , 10'b0000000000};
	22: oInstruction = { `BBMI  , 4'd1,6'd12};     // Si B sigue siendo negativo se devuelve al LOOP1
	23: oInstruction = { `NOP   , 10'b0000000000};
	24: oInstruction = { `NOP   , 10'b0000000000};
	25: oInstruction = { `NOP   , 10'b0000000000};
//LOOP3
	26: oInstruction = { `ORA   , 10'b0000000000}; // Hace un OR de A y B y lo almacena en A
	27: oInstruction = { `NOP   , 10'b0000000000};
	28: oInstruction = { `NOP   , 10'b0000000000};
	29: oInstruction = { `BANE  , 4'd0,6'd5};      // Sigue en el ciclo loop 4 si A es diferente de cero
	30: oInstruction = { `NOP   , 10'b0000000000};
	31: oInstruction = { `NOP   , 10'b0000000000};
	32: oInstruction = { `NOP   , 10'b0000000000};
	33: oInstruction = { `JMP   , `LOOP5};         // Salta al loop5 si A es cero
//LOOP4
	34: oInstruction = { `ANDCA , 10'b0000000000}; // Hace un AND de A con 0 y lo guarda en A
	35: oInstruction = { `NOP   , 10'b0000000000};
	36: oInstruction = { `NOP   , 10'b0000000000};
	37: oInstruction = { `ANDCB , 10'b0000000000}; // Hace un AND de B con 0 y lo guarda en B
	38: oInstruction = { `NOP   , 10'b0000000000};
	39: oInstruction = { `NOP   , 10'b0000000000};
	40: oInstruction = { `JMP   , `LOOP3};
//LOOP5
	41: oInstruction = { `ORCA  , 10'b0001111111};
	42: oInstruction = { `NOP   , 10'b0000000000};
	43: oInstruction = { `NOP   , 10'b0000000000};
	44: oInstruction = { `ADDB  , 10'b0000000000}; // Suma A con B y lo almacena en B
	45: oInstruction = { `NOP   , 10'b0000000000};
	46: oInstruction = { `NOP   , 10'b0000000000};
	47: oInstruction = { `ADDB  , 10'b0000000000}; // Suma A con B y lo almacena en B
	48: oInstruction = { `NOP   , 10'b0000000000};
	49: oInstruction = { `NOP   , 10'b0000000000};
	50: oInstruction = { `BBCS  , 4'd0,6d5};       // Salta al LOOP6
	51: oInstruction = { `NOP   , 10'b0000000000};
	52: oInstruction = { `NOP   , 10'b0000000000};
	53: oInstruction = { `NOP   , 10'b0000000000};
	54: oInstruction = { `JMP   , `FINAL};         // Salta al final
//LOOP6
	55: oInstruction = { `ASRA  , 10'b0000000000}; // Desplaza A hacia la derecha
	56: oInstruction = { `SUBCB , 10'b0000010000}; // Le resta la constante 16 a B
	57: oInstruction = { `NOP   , 10'b0000000000};
	58: oInstruction = { `NOP   , 10'b0000000000};
	59: oInstruction = { `JMP   , `LOOP5};
//FINAL	
	60: oInstruction = { `LDCA  , 10'b0000000001};
	61: oInstruction = { `LDCA  , 10'b0000000010};

	
	default:
		oInstruction = { `NOP ,  10'd0 		};		//NOP
	endcase	
end
	
endmodule
