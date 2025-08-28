`timescale 1ns/1ps

module twos_complement 
  #(parameter N = 64)
  (
    input logic [N-1:0] a,
    output logic [N-1:0] q
);
    always_comb begin
        q = ~a + 1;
    end
endmodule