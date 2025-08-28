module fetch #( parameter N = 64 ) 
	(
		input logic PCSrc_F, clk, reset,
		input logic [N-1:0] PCBranch_F,
		output logic [N-1:0] imem_addr_F
	);
	
	logic [N-1:0] mux_out, add_out; 
	
	mux2 #(64) mux( add_out, PCBranch_F, PCSrc_F, mux_out ); 
	flopr #(64) flop( clk, reset, mux_out, imem_addr_F);
	adder #(64) add( imem_addr_F, 64'd4, add_out );
endmodule 