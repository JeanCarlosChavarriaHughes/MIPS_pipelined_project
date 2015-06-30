module mux4  #(parameter SIZE = 8)( select, d0, d1, d2, d3, q );

input[1:0] select;
input[SIZE-1:0] d0;
input[SIZE-1:0] d1;
input[SIZE-1:0] d2;
input[SIZE-1:0] d3;
output reg [SIZE-1:0] q;


always @( select or d0 or d1 or d2 or d3 )
begin
   case( select )
       0 : q = d0;
       1 : q = d1;
       2 : q = d2;
       3 : q = d3;
   endcase
end

endmodule
