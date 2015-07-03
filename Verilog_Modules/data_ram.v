// Read and write operations of memory
// Memory size is 64 words of four bits each.
module memory (Enable, ReadWrite, Address, DataIn, DataOut);
	input Enable, ReadWrite;
	input [7: 0] DataIn;
	input [9: 0] Address;
	output [7: 0] DataOut;
	reg [7: 0] DataOut;
	reg [7: 0] Mem [0: 1023];
	reg [9:0] k;
	initial
		begin
			DataOut = 0;
			/*for (k = 0; k < 1024 ; k = k + 1) 
				begin 
					Mem[k] = 8'h00; 
				end*/
			Mem[0] = 8'h99; 
			Mem[1] = 8'h99;
			Mem[2] = 8'h99;
			Mem[3] = 8'h99;
			Mem[4] = 8'h99;
			Mem[5] = 8'h99;
			Mem[6] = 8'h99;
			Mem[7] = 8'h99;
			Mem[8] = 8'h99;
			Mem[9] = 8'h99;
		end
	
	// 64 x 4 memory
	always @ (Enable or ReadWrite or DataIn)
		if (Enable)
			if (~ReadWrite) DataOut = Mem [Address];
			// Read
			else Mem [Address] = DataIn;
		// Write
		else DataOut = 4'bz;
		// High impedance state
endmodule
