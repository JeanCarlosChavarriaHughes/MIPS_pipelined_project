//*************************************************//
//***	Author: JeanCarlos Chavarria Hughes		***//
//***			 Alejandro Masis Castillo		***//
//***			 Natalia Araya Campos			***//
//***	email: negrotico19@gmail.com			***//
//***	Part of the pipelined_processor project ***//
//*************************************************//

//url: https://github.com/JeanCarlosChavarriaHughes/MIPS_pipelined_project.git

/* This is the ALU module
* 	One the alu operation is established
*	it is needed to develop the operation 
*	by calculating the arithmetic results
*	and instantiating the corresponding submodules
*/

`ifndef _alu
`define _alu

module alu #(parameter SIZE = 10)(
		input		[2:0]	ctl,
		input		[SIZE-1:0]	in1, in2,
		output reg	[SIZE-1:0]	out,
		output 				carry_out,
		output				zero);

	wire [SIZE-1:0] sub_ab;
	wire [SIZE-1:0] add_ab;
	wire 		oflow_add;
	wire 		oflow_sub;
	wire 		oflow;
	wire 		slt;
	wire [SIZE:0]	tmp;



	assign zero = (0 == out);
	assign carry_out = tmp[SIZE];
	assign add_ab = tmp[SIZE-1:0];

	assign sub_ab = in1 - in2;
	//assign add_ab = in1 + in2; //without carry
	assign tmp = in1 + in2; //with carry

	// overflow occurs (with 2's complement numbers) when
	// the operands have the same sign, but the sign of the result is
	// different.  The actual sign is the opposite of the result.
	// It is also dependent on wheter addition or subtraction is performed.
	assign oflow_add = (in1[SIZE-1] == in2[SIZE-1] && add_ab[SIZE-1] != in1[SIZE-1]) ? 1 : 0;
	assign oflow_sub = (in1[SIZE-1] == in2[SIZE-1] && sub_ab[SIZE-1] != in1[SIZE-1]) ? 1 : 0;

	assign oflow = (ctl == 4'b0010) ? oflow_add : oflow_sub;

	// set if less than, 2s compliment 32-bit numbers
	assign slt = oflow_sub ? ~(in1[SIZE-1]) : in1[SIZE-1];

	always @(*) begin
		case (ctl)
			3'b001: out <= add_ab;				// in1 + in2
			3'b010: out <= in1 & in2;			// and
			3'b101: out <= in1 | in2;			// or
			3'b100: out <= in1 << 1;			// Left Arithmetic shifting  //ASLA
			3'b110: out <= in1 >> 1;			// Right Arithmetic shifting //ASRA
			3'b011: out <= sub_ab;				// in1 - in2
			3'b000: out <= in1;					// Load instruction, ALU assigns in1 to result(data memory address)
			3'b111: out <= 0;				// Branch instruction, ALU does not do anything
			//4'b0111: out <= {{SIZE{1'b0}}, slt};	// set if less than
			//4'b000: out <= ~(in1 | in2);			// nor
			//4'b1101: out <= in1 ^ in2;				// xor
			default: out <= 0;
		endcase
	end

endmodule

`endif