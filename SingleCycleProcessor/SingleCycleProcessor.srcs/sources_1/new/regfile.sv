module regfile (input logic [4:0] ra1, 		// señal de direccionamiento
				input logic [4:0] ra2, 		// señal de direccionamiento
				input logic [4:0] wa3, 		// direcciona registro donde se guardara wd3
				input logic [63:0] wd3, 	//dato contenido
				input logic we3, 			//señal para guardar wd3 en wa3 en flanco ascendente
				input logic clk,			// reloj para determinar flanco ascendente
				output logic [63:0] rd1,  	//puerto de salida de registro indentificado en ra1
				output logic [63:0] rd2); 	//puerto de salida de registro indentificado en ra2

	logic [63:0] registers [0:31] =  '{ 0,  1,  2,  3,
										4,  5,  6,  7,
										8,  9,  10, 11,
										12, 13, 14, 15,
										16, 17, 18, 19,
										20, 21, 22, 23,
										24, 25, 26, 27,
										28, 29, 30, 0};
	always_comb begin
		if (we3 === 1 &&  wa3 === ra1)
			rd1 = wd3;
		else 
			rd1 = registers [ra1];
			
		if (we3 === 1 && wa3 === ra2)
			rd2 = wd3;
		else
			rd2 = registers [ra2];
	end
	
	always_ff @(posedge clk) begin
		if (we3 === 1 & wa3 !== 5'b11111)
			registers [wa3] <= wd3;
	end
		
endmodule