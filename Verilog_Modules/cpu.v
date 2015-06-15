`include "instruction_rom.v"
`include "instruction_decoder.v"
`include "alu.v"
`include "alu_control.v"
`include "ffd.v"
`include "mux4_1.v"
`include "Defintions.v"
`include "data_ram.v"

module cpu(
	
	input clk,
	output wire [7:0] a,
	output wire [7:0] b,
	);

//Instruction Fetch Stage
/*-------------------------------------------------------------*/

//*****************
reg [9:0] pc_out; //Temporal
//*****************


wire [15:0] oInstruction; //Salida de la memoria de instrucciones
instruction_rom Inst_Mem(pc_out, oInstruction);


/*-------------------------------------------------------------*/

//Instruction Decoding Stage
/*-------------------------------------------------------------*/
wire [15:0] instruction_source;
wire [15:0] const; //Salida con los 16 LSB de la instrucción. Usos varios
wire write_to_a; //Salida en alto si la instrucción escribe en el registro A
wire write_to_b; //Salida en alto si la instrucción escribe en el registro A
wire mux_pre_alu_a;//Salida en bajo si se elige enviar a la ALU el contenido del registro A
wire mux_pre_alu_b;//Salida en bajo si se elige enviar a la ALU el contenido del registro B
wire read_write;	//Salida en alto si se va a hacer una escritura en la memoria. Bajo para lectura
wire write_back_mux;//Salida en alto para tomar el dato al que se va a hacer write back de la salida de la memoria. Bajo para que sea la salida de la ALU
wire [1:0] write_mux;	//En el diagrama es Write Mem si no me equivoco.!
wire jump;
wire [3:0] branch_taken;

wire [7:0] a_output;
wire [7:0] b_output;
wire [9:0] a_address;
wire [9:0] b_address;
wire [9:0] id_reg_a_out; 
wire [9:0] id_reg_b_out;

wire [5:0] alu_controller;
wire [7:0] value_to_write_a_ID; 
wire [7:0] value_to_write_b_ID;

//wire []
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

// Outputs
wire [9:0] alu_output_EX; // En el diagrama arquitectonico, creo que es mejor 
				//Si la salida de la alu se trabaja como solo un cable, y 
				// despues en la etapa MEM se bifulca esa signal, alu_output.

// Instances
wire [2:0] oAluCTL;
wire zeroSignal_EX;
alu_control alu_controllerModule(alu_controller_EX, oAluCTL);
alu aluModule #10 (oAluCTL,operand1_EX, operand2_EX, alu_output_EX,	zeroSignal_EX);



/*-------------------------------------------------------------*/

//Memory Stage
/*-------------------------------------------------------------*/

// Inputs
wire [7:0] value_to_write_a_MEM;
wire [7:0] value_to_write_b_MEM;
wire [1:0] write_mux_MEM;
wire [9:0] alu_output_MEM;


// Outputs








/*-------------------------------------------------------------*/

//Write Back Stage
/*-------------------------------------------------------------*/







/*-------------------------------------------------------------*/





//Instruction Fetch Registers
/*-------------------------------------------------------------*/
FFD_POSEDGE_SYNCRONOUS_RESET #16 Instruction_Register( clk, 0, 1, oInstruction, instruction_source);




/*-------------------------------------------------------------*/

//IF/ID Register
/*-------------------------------------------------------------*/





/*-------------------------------------------------------------*/

//ID/EX Register
/*-------------------------------------------------------------*/
FFD_POSEDGE_SYNCRONOUS_RESET #8 ID_EX_RegisterA( clk, 0, 1, value_to_write_a_ID, value_to_write_a_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #8 ID_EX_RegisterB( clk, 0, 1, value_to_write_b_ID, value_to_write_b_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #6 ID_EX_RegisterALUCONTROLLER( clk, 0, 1, const[15:10], alu_controller_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterALUINPUT1( clk, 0, 1, id_reg_a_out, operand1_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterALUINPUT2( clk, 0, 1, id_reg_b_out, operand2_EX);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterWriteMEM( clk, 0, 1, write_mux_EX, write_mux_MEM);

/*-------------------------------------------------------------*/

//EX/MEM Register
/*-------------------------------------------------------------*/

FFD_POSEDGE_SYNCRONOUS_RESET #8 EX_MEM_RegisterA( clk, 0, 1, value_to_write_a_EX, value_to_write_a_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #8 EX_MEM_RegisterB( clk, 0, 1, value_to_write_b_EX, value_to_write_b_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #2 ID_EX_RegisterWriteMEM( clk, 0, 1, write_mux_EX, write_mux_MEM);
FFD_POSEDGE_SYNCRONOUS_RESET #10 ID_EX_RegisterWriteMEM( clk, 0, 1, alu_output_EX, alu_output_MEM);







/*-------------------------------------------------------------*/

//MEM/WB Registers
/*-------------------------------------------------------------*/







/*-------------------------------------------------------------*/




endmodule
