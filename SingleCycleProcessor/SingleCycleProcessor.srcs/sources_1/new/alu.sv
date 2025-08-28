module alu (
            input logic [63:0] a, b,
            input logic [3:0] ALUControl,
            output logic [63:0] result,
            output logic zero
            );
			
	logic [63:0] b_cmpl2;
	complemento_2 #(64) cmpl2_inst (.a(b), .q(b_cmpl2));

	always_comb begin 
		casez(ALUControl) 
			4'b_0000: result = a & b;
			4'b_0001: result = a | b;
			4'b_0010: result = a + b;
			4'b_0110: result = a + b_cmpl2;
			4'b_0111: result = b;
			
			default: result = '0; 
		endcase 
		zero = (result == '0 ) ? '1 : '0; 
	end
endmodule 