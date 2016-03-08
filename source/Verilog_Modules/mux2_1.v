module mux2 #(parameter SIZE = 10)( select, d0, d1, q );

input select;
input[SIZE-1:0] d0;
input[SIZE-1:0] d1;
output reg [SIZE-1:0] q;


always @( select or d0 or d1)
begin
   case( select )
       0 : q = d0;
       1 : q = d1;
   endcase
end

endmodule
