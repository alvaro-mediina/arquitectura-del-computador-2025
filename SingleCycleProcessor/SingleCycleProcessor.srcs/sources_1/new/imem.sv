module imem #(parameter N = 32)
				 (input logic [6:0]addr,
				  output logic [N-1:0]q);
	
	//Inicializo las 128 posiciones en 0
	logic [N-1:0] ROM [0:127] = '{default: 32'h0};
	
	initial begin
		ROM = '{default:'0};
		$readmemh("progs/WithoutAddiSubi.txt", ROM);
	end
	
	assign q = ROM[addr];
	
endmodule
