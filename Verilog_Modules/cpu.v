`include "instruction_rom.v"
`include "instruction_decoder.v"
`include "alu.v"
`include "alu_control.v"
`include "ffd.v"
`include "mux4_1.v"
`include "mux2_1.v"
`include "reg.v"
`include "status.v"
`include "branch_calc.v"
`include "branch_taken.v"
`include "Defintions.v"
`include "data_ram.v"
`include "forwarding_unit.v"

module cpu(
	
	input clk,
	output [7:0] a,
	output [7:0] b
	);

//Instruction Fetch Stage
/*-------------------------------------------------------------*/

wire [9:0] pc_plus_one_IF;
wire [9:0] 	pc_IF;

wire [15:0] oInstruction; //Salida de la memoria de instrucciones
instruction_rom Inst_Mem(pc_IF, oInstruction);

mux2 mux_pc(taken_MEM, pc_plus_one_ID, new_pc_MEM, pc_IF);

assign pc_plus_one_IF = pc_IF + 1'b1;


/*-------------------------------------------------------------*/

//Instruction Decoding Stage
/*-------------------------------------------------------------*/
wire [15:0] instruction_source;
wire [15:0] const; //Salida con los 16 LSB de la instrucción. Usos varios
wire write_to_a_ID; //Salida en alto si la instrucción escribe en el registro A
wire write_to_b_ID; //Salida en alto si la instrucción escribe en el registro A
wire mux_pre_alu_a;//Salida en bajo si se elige enviar a la ALU el contenido del registro A
wire mux_pre_alu_b;//Salida en bajo si se elige enviar a la ALU el contenido del registro B
wire read_write_ID;	//Salida en alto si se va a hacer una escritura en la memoria. Bajo para lectura
wire write_back_mux;//Salida en alto para tomar el dato al que se va a hacer write back de la salida de la memoria. Bajo para que sea la salida de la ALU
wire [1:0] write_mux;	//En el diagrama es Write Mem si no me equivoco.!
wire jump_ID;
wire [3:0] branch_taken;

wire [7:0] a_output;
wire [7:0] b_output;
wire [9:0] a_address;
wire [9:0] b_address;
wire [9:0] id_reg_a_out; 
wire [9:0] id_reg_b_out;
wire [9:0] pc_ID;
wire [9:0] pc_plus_one_ID;

wire [7:0] regA_output;
wire [7:0] regB_output;

wire [5:0] alu_controller;
wire [7:0] value_to_write_a_ID; 
wire [7:0] value_to_write_b_ID;

wire [9:0] operand1_IF;
wire [9:0] operand2_IF;
wire reg_write_selector_a, reg_write_selector_b;
wire [9:0] branch_value_ID;
wire muxA_ID, muxB_ID;
wire ZA, ZB, CA, CB, NA, NB, taken_ID;

wire [7:0] reg_a_input, reg_b_input;

assign reg_write_selector_a = write_to_a_WB|muxA_EX;
assign reg_write_selector_b = write_to_b_WB|muxB_EX;

register regA(reg_a_input, reg_write_selector_a, regA_output );
register regB(reg_b_input, reg_write_selector_b, regB_output );

mux2 #8 pre_reg_a(muxA_EX, result_WB, alu_output_EX[7:0], reg_a_input);
mux2 #8 pre_reg_b(muxB_EX, result_WB, alu_output_EX[7:0], reg_b_input);

mux2 oper_a( mux_pre_alu_a, {2'b0,regA_output} , const[9:0], operand1_IF );
mux2 oper_b( mux_pre_alu_b, {2'b0,regB_output}, const[9:0], operand2_IF );

//---------------------------------------------------------------
status stat_calc(regA_output,regB_output,carry_out_EX,carry_out_EX,CA, CB, ZA, ZB, NA, NB);//Problema con los carries que se debe solucionar
//---------------------------------------------------------------

branch_taken btaken(branch_taken, ZA,ZB,NA,NB,CA,CB,taken_ID);
branch_calc branch1(pc_ID,const,branch_value_ID);

forwarding forw_unit(clk, oInstruction[15:10], muxA_ID, muxB_ID);


//Provisional
assign a = regA_output;
assign b = regB_output;
//*________________________________________________________________


/*-------------------------------------------------------------*/



//Execution Stage
/*-------------------------------------------------------------*/

// Inputs
wire [7:0] value_to_write_a_EX;		// es una output tambien
wire [7:0] value_to_write_b_EX;		// es una output tambien
wire [5:0] alu_controller_EX;	
wire [9:0] operand1_EX;
wire [9:0] operand2_EX;
wire [1:0] write_mux_EX;			// Senal de control, selecciona que escribir en Data Memory, es output tambien
wire write_to_a_EX; //Salida en alto si la instrucción escribe en el registro A
wire write_to_b_EX;
wire read_write_EX;
wire [15:0] const_EX;
// Outputs
wire [9:0] alu_output_EX; // En el diagrama arquitectonico, creo que es mejor 
				//Si la salida de la alu se trabaja como solo un cable, y 
				// despues en la etapa MEM se bifulca esa signal, alu_output.
wire [9:0] branch_value_EX;
wire [9:0] pc_EX;
wire [9:0] new_pc_EX;
wire muxA_EX, muxB_EX;
// Instances
wire [2:0] oAluCTL;
wire zeroSignal_EX, carry_out_EX;
wire jump_EX, taken_EX;
alu_control alu_controllerModule(alu_controller_EX, oAluCTL);
alu #10 aluModule (oAluCTL,operand1_EX, operand2_EX, alu_output_EX, carry_out_EX, zeroSignal_EX);

mux4 #10 branch_mux ( {jump_EX,taken_EX}, pc_EX, branch_value_EX, const_EX[9:0], const_EX[9:0], new_pc_EX );


/*-------------------------------------------------------------*/

//Memory Stage
/*-------------------------------------------------------------*/

// Inputs
wire [7:0] value_to_write_a_MEM;
wire [7:0] value_to_write_b_MEM;
wire [1:0] write_mux_MEM;
wire [9:0] alu_output_MEM;
wire [7:0] mux_output_MEM;
reg [7:0] zeros;
wire read_write_MEM;
wire taken_MEM;
wire [9:0] new_pc_MEM;
wire write_to_a_MEM; //Salida en alto si la instrucción escribe en el registro A
wire write_to_b_MEM;
// Outputs
wire [7:0] data_out_MEM;
initial zeros = 0;

mux4 mem_mux(write_mux_MEM, alu_output_MEM[7:0], {value_to_write_a_MEM}, {value_to_write_b_MEM}, zeros, mux_output_MEM);
memory ram(1'b1, read_write_MEM, alu_output_MEM, mux_output_MEM, data_out_MEM);






/*-------------------------------------------------------------*/

//Write Back Stage
/*-------------------------------------------------------------*/

wire [7:0] alu_output_WB;
wire [7:0] data_out_WB;
wire [7:0] result_WB;
wire write_to_a_WB; //Salida en alto si la instrucción escribe en el registro A
wire write_to_b_WB;

mux2 #8 wb_stage(write_back_mux, alu_output_WB, data_out_WB, result_WB);



/*-------------------------------------------------------------*/





//Instruction Fetch Registers
/*-------------------------------------------------------------*/



//IF/ID Register
/*-------------------------------------------------------------*/

FFD_POSEDGE_SYNCRONOUS_RESET #16 Instruction_Register( clk, 0, 1'b1, oInstruction, instruction_source);
FFD_POSEDGE_SYNCRONOUS_RESET #10 PC_Register( clk, 0, 1'b1, pc_plus_one_IF, pc_plus_one_ID);
FFD_POSEDGE_SYNCRONOUS_RESET #10 PC_ToBranch( clk, 0, 1'b1, pc_IF, pc_ID);


/*-------------------------------------------------------------*/

//ID/EX Register
/*-------------------------------------------------------------*/
FFD_POSEDGE_SYNCRONOUS_RESET #8 ID_EX_RegisterA( clk, 0, 1'b1, value_to_write_a_ID, value_to_write_a_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #8 ID_EX_RegisterB( clk, 0, 1'b1, value_to_write_b_ID, value_to_write_b_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #6 ID_EX_RegisterALUCONTROLLER( clk, 0, 1'b1, const[15:10], alu_controller_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterALUINPUT1( clk, 0, 1'b1, id_reg_a_out, operand1_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterALUINPUT2( clk, 0, 1'b1, id_reg_b_out, operand2_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #2 ID_EX_RegisterWriteMEM( clk, 0, 1'b1, write_mux, write_mux_EX);

FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_WriteToA( clk, 0, 1'b1, write_to_a_ID, write_to_a_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_WriteToB( clk, 0, 1'b1, write_to_b_ID, write_to_b_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_ReadWrite( clk, 0, 1'b1, read_write_ID, read_write_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_Jump( clk, 0, 1'b1, jump_ID, jump_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_Taken( clk, 0, 1'b1, taken_ID, taken_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_MuxA( clk, 0, 1'b1, muxA_ID, muxA_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_MuxB( clk, 0, 1'b1, muxB_ID, muxB_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #16 ID_EX_Const ( clk, 0, 1'b1, const, const_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_PC( clk, 0, 1'b1, pc_ID, pc_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_BranchValue( clk, 0, 1'b1, branch_value_ID, branch_value_EX);

/*-------------------------------------------------------------*/

//EX/MEM Register
/*-------------------------------------------------------------*/

FFD_POSEDGE_SYNCRONOUS_RESET #8 EX_MEM_RegisterA( clk, 0, 1'b1, value_to_write_a_EX, value_to_write_a_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #8 EX_MEM_RegisterB( clk, 0, 1'b1, value_to_write_b_EX, value_to_write_b_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #2 EX_MEM_WriteMux( clk, 0, 1'b1, write_mux_EX, write_mux_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #10 EX_MEM_ALUOutput( clk, 0, 1'b1, alu_output_EX, alu_output_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #10 EX_MEM_NewPC( clk, 0, 1'b1, new_pc_EX, new_pc_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_WriteToA( clk, 0, 1'b1, write_to_a_EX, write_to_a_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_WriteToB( clk, 0, 1'b1, write_to_b_EX, write_to_b_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_ReadWrite( clk, 0, 1'b1, read_write_EX, read_write_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_Taken( clk, 0, 1'b1, taken_EX, taken_MEM);


/*-------------------------------------------------------------*/

//MEM/WB Registers
/*-------------------------------------------------------------*/


FFD_POSEDGE_SYNCRONOUS_RESET #8 MEM_WB_ALUOutput( clk, 0, 1'b1, alu_output_MEM[7:0], alu_output_WB);
FFD_POSEDGE_SYNCRONOUS_RESET #8 MEM_WB_DataOut( clk, 0, 1'b1, data_out_MEM, data_out_WB);
FFD_POSEDGE_SYNCRONOUS_RESET #1 MEM_WB_WriteToA( clk, 0, 1'b1, write_to_a_MEM, write_to_a_WB);
FFD_POSEDGE_SYNCRONOUS_RESET #1 MEM_WB_WriteToB( clk, 0, 1'b1, write_to_b_MEM, write_to_b_WB);



/*-------------------------------------------------------------*/




endmodule
