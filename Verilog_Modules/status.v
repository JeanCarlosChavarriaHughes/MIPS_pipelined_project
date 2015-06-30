module status(
	input [7:0] regA,
	input [7:0] regB,
	input carryA,
	input carryB,
	output reg CA, CB, ZA, ZB, NA, NB
	);

always @(*)
	begin
		ZA = ~|regA;
		ZB = ~|regB;
		NA = regA[7];
		NB = regB[7];
		CA = carryA;
		CB = carryB;
	end


endmodule
