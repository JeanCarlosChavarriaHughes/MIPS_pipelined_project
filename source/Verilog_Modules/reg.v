`timescale 1ns / 100ps

module register(

	input [7:0] in,
	input select,
	output reg [7:0] out
	);

initial
	begin
	out = 0;
	end

always @(select or in)
	begin
	#1 if (select)
		begin
		out = in;
		end
	end

endmodule
