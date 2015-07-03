`timescale 1ns / 1ps
module branch_taken(
	input wire [3:0] branch_taken,	// Valor del branch taken proveniente del instruction decoder
	input wire ZA,					// Bandera de cero para el registro A.
	input wire ZB,					// Bandera de cero para el registro B.
	input wire NA,					// Bandera de signo para el registro A.
	input wire NB,					// Bandera de signo para el registro B.
	input wire CA,					// Bandera de acarreo para el registro A.
	input wire CB,					// Bandera de acarreo para el registro B.
	output reg taken				// Indica si el branch se toma o no.
	);
	
	always @(*)
	begin
		if(branch_taken == 0)			// Revisa si se toma el salto BAEQ.
			begin
				taken = 0;
			end
			
		if(branch_taken == 1)			// Revisa si se toma el salto BAEQ.
			begin
				if(ZA == 1)				
					taken = 1;
					
				else				
					taken = 0;
			end
			
		else if(branch_taken == 2)		// Revisa si se toma el salto BANE.
			begin
				if(ZA == 0)				
					taken = 1;
					
				else				
					taken = 0;
					
			end
			
		else if(branch_taken == 3)		// Revisa si se toma el salto BACS.
			begin
				if(CA == 1)				
					taken = 1;
					
				else					
					taken = 0;
					
			end
			
		else if(branch_taken == 4)		// Revisa si se toma el salto BACC.
			begin
				if(CA == 0)				
					taken = 1;
					
				else				
					taken = 0;
					
			end
			
		else if(branch_taken == 5)		// Revisa si se toma el salto BAMI.
			begin
				if(NA == 1)				
					taken = 1;
					
				else				
					taken = 0;
					
			end
			
		else if(branch_taken == 6)		// Revisa si se toma el salto BAPL.
			begin
				if(NA == 0)				
					taken = 1;
					
				else				
					taken = 0;
					
			end
			
		else if(branch_taken == 7)		// Revisa si se toma el salto BBEQ.
			begin
				if(ZB == 1)				
					taken = 1;
					
				else				
					taken = 0;
					
			end
			
		else if(branch_taken == 8)		// Revisa si se toma el salto BBNE.
			begin
				if(ZB == 0)				
					taken = 1;
					
				else			
					taken = 0;
					
			end
			
		else if(branch_taken == 9)		// Revisa si se toma el salto BBCS.
			begin
				if(CB == 1)				
					taken = 1;
					
				else				
					taken = 0;
					
			end
			
		else if(branch_taken == 10)		// Revisa si se toma el salto BBCC.
			begin
				if(CB == 0)
					taken = 1;
					
				else				
					taken = 0;
					
			end
			
		else if(branch_taken == 11)		// Revisa si se toma el salto BBMI.
			begin
				if(NB == 1)				
					taken = 1;
					
				else
					taken = 0;
					
			end
			
		else if(branch_taken == 12)		// Revisa si se toma el salto BBPL.
			begin
				if(NB == 0)			
					taken = 1;
					
				else				
					taken = 0;
					
			end
	end
	
endmodule
