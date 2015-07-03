//*************************************************//
//***	Authors: JeanCarlos Chavarria Hughes	***//
//***			 Alejandro Masis Castillo		***//
//***			 Natalia Araya Campos			***//
//***	email: negrotico19@gmail.com			***//
//***	Part of the pipelined_processor project ***//
//*************************************************//

//url: https://github.com/JeanCarlosChavarriaHughes/MIPS_pipelined_project.git

/* This is the ALU_Controller module
* 	The operation that ALU needs to perform is 
* 	selected by the alu_operation signal which can 
* 	take values or 3 bits.
*	The 6 MSB of the instruccion are used to select 
*	which operation is needed.
*/



`ifndef _alu_control
`define _alu_control

module alu_control(iInstruction_wire, oAluctl_reg);

	input wire [5:0] iInstruction_wire; //The 6 MBS of the instruction
	output reg [2:0] oAluctl_reg; //Selects the operation that alu needs to perform.

//	reg [3:0] _funct = 4'd0;

	always @(*) begin
		case(iInstruction_wire[5:0])
				
			/*
			*	The six first ones instructions are related with the
			*	memory allocation operations. Then, ALU just  needs to 
			*	connect the output with the first input as a memory address
			*/

			6'o00:	oAluctl_reg = 3'o0; 	//LDA
			6'o01:	oAluctl_reg = 3'o0;		//LDB
			6'o02:	oAluctl_reg = 3'o0;		//LDCA
			6'o03:	oAluctl_reg = 3'o0;		//LDCB
			6'o04:	oAluctl_reg = 3'o0;		//STA
			6'o05:	oAluctl_reg = 3'o0;		//STB

			/*	
			*	The four second ones instructions are related with the
			*	addition operations. Then, ALU just  needs to 
			*	perform an addition with the two inputs.
			*/

			6'o06:	oAluctl_reg = 3'o1;		//ADDA
			6'o07:	oAluctl_reg = 3'o1;		//ADDB
			6'o10:	oAluctl_reg = 3'o1;		//ADDCA
			6'o11:	oAluctl_reg = 3'o1;		//ADDCB

			/*	
			*	The four third ones instructions are related with the
			*	substraction operations. Then, ALU just  needs to 
			*	perform an substraction with the two inputs.
			*/

			6'o12:	oAluctl_reg = 3'o3;		//SUBA
			6'o13:	oAluctl_reg = 3'o3;		//SUBB
			6'o14:	oAluctl_reg = 3'o3;		//SUBCA
			6'o15:	oAluctl_reg = 3'o3;		//SUBCB

			/*	
			*	The four fourth ones instructions are related with the
			*	bit-to-bit AND operation. Then, ALU just  needs to 
			*	perform an AND operation with the two inputs.
			*/

			6'o16:	oAluctl_reg = 3'o2;		//ANDA
			6'o17:	oAluctl_reg = 3'o2;		//ANDB
			6'o20:	oAluctl_reg = 3'o2;		//ANDCA
			6'o21:	oAluctl_reg = 3'o2;		//ANDCB

			/*	
			*	The four fifth ones instructions are related with the
			*	bit-to-bit OR operation. Then, ALU just  needs to 
			*	perform an OR operation with the two inputs.
			*/

			6'o22:	oAluctl_reg = 3'o5;		//ORA
			6'o23:	oAluctl_reg = 3'o5;		//ORB
			6'o24:	oAluctl_reg = 3'o5;		//ORCA
			6'o25:	oAluctl_reg = 3'o5;		//ORCB

			/*	
			*	The 0x16 instruction are related with the
			*	arithmetic left shifting operation. Then, ALU just needs to 
			*	perform an left shifting operation with the first input.
			*/

			6'o26:	oAluctl_reg = 3'o4;		//ASLA

			/*	
			*	The 0x17 instruction are related with the
			*	arithmetic rigth shifting operation. Then, ALU just needs to 
			*	perform an rigth shifting operation with the first input.
			*/

			6'o27:	oAluctl_reg = 3'o6;		//ASRA

			/*	
			*	The instructions from 0x18 to 0x25 do not need any
			* 	alu calculation since they all are branches, jumps or nops.
			*/

			6'o30:	oAluctl_reg = 3'o7;		//JMP
			6'o31:	oAluctl_reg = 3'o7;		//BAEQ
			6'o32:	oAluctl_reg = 3'o7;		//BANE
			6'o33:	oAluctl_reg = 3'o7;		//BACS
			6'o34:	oAluctl_reg = 3'o7;		//BACC
			6'o35:	oAluctl_reg = 3'o7;		//BAMI
			6'o36:	oAluctl_reg = 3'o7;		//BAPL
			6'o37:	oAluctl_reg = 3'o7;		//BBEQ
			6'o40:	oAluctl_reg = 3'o7;		//BBNE
			6'o41:	oAluctl_reg = 3'o7;		//BBCS
			6'o42:	oAluctl_reg = 3'o7;		//BBCC
			6'o43:	oAluctl_reg = 3'o7;		//BBMI
			6'o44:	oAluctl_reg = 3'o7;		//BBPL
			6'o45:	oAluctl_reg = 3'o7;		//NOP

			default: oAluctl_reg = 3'o7;	//the default state simulates a NOP operation
		endcase
	end

endmodule

`endif