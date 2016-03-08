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

	0: oInstruction =  { `NOP   , 10'b0000000000};
	1: oInstruction =  { `NOP   , 10'b0000000000};
	2: oInstruction =  { `NOP   , 10'b0000000000}; 
	3: oInstruction =  { `NOP   , 10'b0000000000};
	4: oInstruction =  { `NOP   , 10'b0000000000};
	5: oInstruction =  { `LDCA  , 10'b0000000010}; // Carga la constante 18 en A
	6: oInstruction =  { `LDCB  , 10'b0000000001}; // Carga la constante 3 en B
//LOOP1:	
	7: oInstruction =  { `NOP  , 10'b0000000000}; // Resta A menos B y lo guarda en A
	8: oInstruction =  { `SUBA   , 10'b0000000000};
	9: oInstruction =  { `NOP   , 10'b0000000000};
	10: oInstruction = { `BANE  , 4'd1,6'd3};      // Sigue en el ciclo hasta que se cumpla A = 0 (LOOP1)
	11: oInstruction = { `NOP   , 10'b0000000000};
	12: oInstruction = { `NOP   , 10'b0000000000}; 
	13: oInstruction = { `NOP   , 10'b0000000000}; 
	14: oInstruction = { `ORCB  , 10'b0000111000}; // Hace una OR de B con 111000 -> 111111 (63)
	15: oInstruction = { `STB   , 10'b1000000010}; // Almacena B en 514
	16: oInstruction = { `ORCB  , 10'b0001000000}; // Hace una OR de B con 1000000 -> 1111000 (120)
	17: oInstruction = { `LDA   , 10'b1000000010}; // Carga en A el valor de la dirección 514
	18: oInstruction = { `NOP   , 10'b0000000000};
//LOOP2:
	19: oInstruction = { `SUBB  , 10'b0000000000}; // Resta B menos A y lo guarda en B
	20: oInstruction = { `NOP   , 10'b0000000000};
	21: oInstruction = { `NOP   , 10'b0000000000};
	22: oInstruction = { `BBPL  , 4'd1,6'd3};      // Sigue el ciclo hasta que B sea negativo (LOOP2)
	23: oInstruction = { `NOP   , 10'b0000000000}; 
	24: oInstruction = { `NOP   , 10'b0000000000};
	25: oInstruction = { `NOP   , 10'b0000000000};
//LOOP3:
	26: oInstruction = { `ASRA  , 10'b0000000000}; // Desplaza A hacia la derecha y lo guarda en A
	//29: oInstruction = { `NOP   , 10'b0000000000}; 
	//29: oInstruction = { `NOP   , 10'b0000000000}; 
	27: oInstruction = { `ANDB  , 10'b0000000000}; // Hace una AND de B con A
	//29: oInstruction = { `NOP   , 10'b0000000000}; 
	//29: oInstruction = { `NOP   , 10'b0000000000}; 
	28: oInstruction = { `BBEQ  , 4'd1,6'd6};      // Sigue el ciclo hasta que B sea negativo (LOOP3)
	29: oInstruction = { `NOP   , 10'b0000000000}; 
	30: oInstruction = { `NOP   , 10'b0000000000}; 
	31: oInstruction = { `NOP   , 10'b0000000000};
	32: oInstruction = { `STA   , 10'b1000000010}; // Almacena A en 514
	
	default:
		oInstruction = { `NOP ,  10'd0 		};		//NOP
	endcase	
end
	
endmodule
