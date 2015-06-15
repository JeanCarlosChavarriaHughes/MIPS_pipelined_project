// Read and write operations of memory
// Memory size is 64 words of four bits each.
module memory (Enable, ReadWrite, Address, DataIn, DataOut);
	input Enable, ReadWrite;
	input [7: 0] DataIn;
	input [9: 0] Address;
	output [7: 0] DataOut;
	reg [7: 0] DataOut;
	reg [7: 0] Mem [0: 1023];
	
	initial
		begin
			Mem[0] = $random(0)% 10000;
		end
	
	// 64 x 4 memory
	always @ (Enable or ReadWrite)
		if (Enable)
			if (ReadWrite) DataOut = Mem [Address];
			// Read
			else Mem [Address] = DataIn;
		// Write
		else DataOut = 4'bz;
		// High impedance state
endmodule
