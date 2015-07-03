`include "../Verilog_Modules/instruction_rom.v"
`include "../Verilog_Modules/instruction_decoder.v"
`include "../Verilog_Modules/alu.v"
`include "../Verilog_Modules/alu_control.v"
`include "../Verilog_Modules/ffd.v"
`include "../Verilog_Modules/mux4_1.v"
`include "../Verilog_Modules/mux2_1.v"
`include "../Verilog_Modules/reg.v"
`include "../Verilog_Modules/status_selector.v"
`include "../Verilog_Modules/branch_calc.v"
`include "../Verilog_Modules/branch_taken.v"
`include "../Verilog_Modules/Defintions.v"
`include "../Verilog_Modules/data_ram.v"
`include "../Verilog_Modules/forwarding_unit.v"

module cpu(
	
	input clk,
	input reset,
	output [7:0] a,
	output [7:0] b
	);

//Instruction Fetch Stage
/*-------------------------------------------------------------*/

wire [9:0] pc_plus_one_IF;
wire [9:0] 	pc_IF;

wire [15:0] oInstruction; //Salida de la memoria de instrucciones
instruction_rom Inst_Mem(pc_IF, oInstruction);
wire mux_pc_select;

assign mux_pc_select = taken_MEM|jump_MEM;
mux2 mux_pc(mux_pc_select, pc_plus_one_ID, new_pc_MEM, pc_IF);

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
wire reset_ID;
wire [7:0] a_output;
wire [7:0] b_output;
wire [9:0] a_address;
wire [9:0] b_address;
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

wire outputA_EX, outputA_MEM, outputB_EX, outputB_MEM;

assign reg_write_selector_a = write_to_a_WB|outputA_EX|outputA_MEM;
assign reg_write_selector_b = write_to_b_WB|outputB_EX|outputB_MEM;

assign value_to_write_a_ID = regA_output;
assign value_to_write_b_ID = regB_output;

inst_decoder decoder1(
	
	instruction_source, //Entrada con la instruccion obtenida de la ROM
	const, //Salida con los 10 LSB de la instrucción. Usos varios
	write_to_a_ID, //Salida en alto si la instrucción escribe en el registro A
	write_to_b_ID, //Salida en alto si la instrucción escribe en el registro A
	mux_pre_alu_a,//Salida en bajo si se elige enviar a la ALU el contenido del registro A
	mux_pre_alu_b,//Salida en bajo si se elige enviar a la ALU el contenido del registro B
	read_write_ID,	//Salida en alto si se va a hacer una escritura en la memoria. Bajo para lectura
	write_back_mux,//Salida en alto para tomar el dato al que se va a hacer write back de la salida de la memoria. Bajo para que sea la salida de la ALU
	write_mux,
	jump_ID,
	branch_taken
	);

register regA(reg_a_input, reg_write_selector_a, regA_output );
register regB(reg_b_input, reg_write_selector_b, regB_output );

mux4 #8 pre_reg_a({outputA_MEM, outputA_EX}, result_WB, alu_output_EX[7:0], data_out_MEM, alu_output_EX[7:0], reg_a_input);
mux4 #8 pre_reg_b({outputB_MEM, outputB_EX}, result_WB, alu_output_EX[7:0], data_out_MEM, alu_output_EX[7:0], reg_b_input);

mux2 oper_a( mux_pre_alu_a, {2'b0,regA_output} , const[9:0], operand1_IF );
mux2 oper_b( mux_pre_alu_b, {2'b0,regB_output}, const[9:0], operand2_IF );

//---------------------------------------------------------------
status_selector stat_calc(const_EX[15:10],regA_output, regB_output, zeroSignal_EX, carry_out_EX, alu_output_EX[7], CA, CB, ZA, ZB, NA, NB); 
//---------------------------------------------------------------

branch_taken btaken(branch_taken, ZA,ZB,NA,NB,CA,CB,taken_ID);
branch_calc branch1(pc_ID,const,branch_value_ID);

forwarding forw_unit(clk, oInstruction[15:10],const[15:10],const_EX[15:10],outputA_EX, outputA_MEM, outputB_EX, outputB_MEM);

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
wire reset_EX;
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
wire jump_EX, taken_EX, write_back_mux_EX;
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
wire reset_MEM;
reg [7:0] zeros;
wire read_write_MEM;
wire taken_MEM;
wire [9:0] new_pc_MEM;
wire write_to_a_MEM; //Salida en alto si la instrucción escribe en el registro A
wire write_to_b_MEM;
wire jump_MEM;
// Outputs
wire [7:0] data_out_MEM;
initial zeros = 0;
wire write_back_mux_MEM;
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
wire reset_WB;
wire write_back_mux_WB;
mux2 #8 wb_stage(write_back_mux_WB, alu_output_WB, data_out_WB, result_WB);



/*-------------------------------------------------------------*/





//Instruction Fetch Registers
/*-------------------------------------------------------------*/



//IF/ID Register
/*-------------------------------------------------------------*/

FFD_POSEDGE_SYNCRONOUS_RESET #16 Instruction_Register( clk, reset, 1'b1, oInstruction, instruction_source);
FFD_POSEDGE_SYNCRONOUS_RESET #10 PC_Register( clk, reset, 1'b1, pc_plus_one_IF, pc_plus_one_ID);
FFD_POSEDGE_SYNCRONOUS_RESET #10 PC_ToBranch( clk, reset, 1'b1, pc_IF, pc_ID);
FFD_POSEDGE_SYNCRONOUS_RESET #1 IF_ID_Reset( clk, 0, 1'b1, reset, reset_ID);

/*-------------------------------------------------------------*/

//ID/EX Register
/*-------------------------------------------------------------*/
FFD_POSEDGE_SYNCRONOUS_RESET #8 ID_EX_RegisterA( clk, reset_ID, 1'b1, value_to_write_a_ID, value_to_write_a_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #8 ID_EX_RegisterB( clk, reset_ID, 1'b1, value_to_write_b_ID, value_to_write_b_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #6 ID_EX_RegisterALUCONTROLLER( clk, reset_ID, 1'b1, const[15:10], alu_controller_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterALUINPUT1( clk, reset_ID, 1'b1, operand1_IF, operand1_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterALUINPUT2( clk, reset_ID, 1'b1, operand2_IF, operand2_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #2 ID_EX_RegisterWriteMEM( clk, reset_ID, 1'b1, write_mux, write_mux_EX);

FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_WriteToA( clk, reset_ID, 1'b1, write_to_a_ID, write_to_a_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_WriteToB( clk, reset_ID, 1'b1, write_to_b_ID, write_to_b_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_ReadWrite( clk, reset_ID, 1'b1, read_write_ID, read_write_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_Jump( clk, reset_ID, 1'b1, jump_ID, jump_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_Taken( clk, reset_ID, 1'b1, taken_ID, taken_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_MuxA( clk, reset_ID, 1'b1, muxA_ID, muxA_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_MuxB( clk, reset_ID, 1'b1, muxB_ID, muxB_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #16 ID_EX_Const ( clk, reset_ID, 1'b1, const, const_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_PC( clk, reset_ID, 1'b1, pc_ID, pc_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_BranchValue( clk, reset_ID, 1'b1, branch_value_ID, branch_value_EX);

FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_Reset( clk, 0, 1'b1, reset_ID, reset_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #1 ID_EX_WriteBackMux( clk, 0, 1'b1, write_back_mux, write_back_mux_EX);
/*-------------------------------------------------------------*/

//EX/MEM Register
/*-------------------------------------------------------------*/

FFD_POSEDGE_SYNCRONOUS_RESET #8 EX_MEM_RegisterA( clk, reset_EX, 1'b1, value_to_write_a_EX, value_to_write_a_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #8 EX_MEM_RegisterB( clk, reset_EX, 1'b1, value_to_write_b_EX, value_to_write_b_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #2 EX_MEM_WriteMux( clk, reset_EX, 1'b1, write_mux_EX, write_mux_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #10 EX_MEM_ALUOutput( clk, reset_EX, 1'b1, alu_output_EX, alu_output_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #10 EX_MEM_NewPC( clk, reset_EX, 1'b1, new_pc_EX, new_pc_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_WriteToA( clk, reset_EX, 1'b1, write_to_a_EX, write_to_a_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_WriteToB( clk, reset_EX, 1'b1, write_to_b_EX, write_to_b_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_ReadWrite( clk, reset_EX, 1'b1, read_write_EX, read_write_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_Taken( clk, reset_EX, 1'b1, taken_EX, taken_MEM);

FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_Reset( clk, 0, 1'b1, reset_EX, reset_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_WriteBackMux( clk, reset_EX, 1'b1, write_back_mux_EX, write_back_mux_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #1 EX_MEM_Jump( clk, reset_EX, 1'b1, jump_EX, jump_MEM);
/*-------------------------------------------------------------*/

//MEM/WB Registers
/*-------------------------------------------------------------*/


FFD_POSEDGE_SYNCRONOUS_RESET #8 MEM_WB_ALUOutput( clk, reset_EX, 1'b1, alu_output_MEM[7:0], alu_output_WB);
FFD_POSEDGE_SYNCRONOUS_RESET #8 MEM_WB_DataOut( clk, reset_EX, 1'b1, data_out_MEM, data_out_WB);
FFD_POSEDGE_SYNCRONOUS_RESET #1 MEM_WB_WriteToA( clk, reset_EX, 1'b1, write_to_a_MEM, write_to_a_WB);
FFD_POSEDGE_SYNCRONOUS_RESET #1 MEM_WB_WriteToB( clk, reset_EX, 1'b1, write_to_b_MEM, write_to_b_WB);

FFD_POSEDGE_SYNCRONOUS_RESET #1 MEM_WB_Reset( clk, 0, 1'b1, reset_MEM, reset_WB);
FFD_POSEDGE_SYNCRONOUS_RESET #1 MEM_WB_WriteBackMux( clk, 0, 1'b1, write_back_mux_MEM, write_back_mux_WB);
/*-------------------------------------------------------------*/




endmodule
