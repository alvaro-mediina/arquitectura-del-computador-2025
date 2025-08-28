`timescale 1 ns / 100 ps
`define clk_freq 5 
`define testvector_size 20

module execute_tb();
	
	logic AluSrc;
	logic [3:0] AluControl;
	logic [63:0] PC_E, signImm_E, readData1_E, readData2_E;
	logic [63:0] PCBranch_E, aluResult_E, writeData_E;
	logic zero_E;
	
	logic clk;
	logic [195:0] expected_output;
	logic [31:0] error;
	logic [4:0] vector_num;
	logic [459:0] testvectors [0:`testvector_size-1];
	logic [3:0] AluSrc_aux, zero_E_aux;
	
	execute dut (.AluSrc(AluSrc), 
					 .AluControl(AluControl),
					 .PC_E(PC_E), .signImm_E(signImm_E), .readData1_E(readData1_E), .readData2_E(readData2_E),
					 .PCBranch_E(PCBranch_E), .aluResult_E(aluResult_E), .writeData_E(writeData_E),
					 .zero_E(zero_E));
	
	always begin
		clk = 1; #`clk_freq;
		clk = 0; #`clk_freq;
	end
	
	initial begin
		vector_num = 0; error = 0;
		$readmemh("testvectors/execute_test.tv", testvectors);
		{AluSrc_aux, AluControl, PC_E, signImm_E, readData1_E, readData2_E, expected_output} = testvectors [0];
		AluSrc = AluSrc_aux[0];
	end
	
	always @(posedge clk) begin
		#2;
		if ($bits(testvectors[vector_num]) !== 460) begin
			$display("Error: Vector de prueba en linea %d tiene un ancho incorrecto, ancho esperado %d", vector_num, $bits(testvectors[vector_num]));
			$stop;
		end
		{AluSrc_aux, AluControl, PC_E, signImm_E, readData1_E, readData2_E, expected_output} = testvectors [vector_num];
		AluSrc = AluSrc_aux[0];
		
		$display ("%h \n", expected_output);
	end
	
	always @(negedge clk) begin
		#2;
		zero_E_aux = zero_E;
		if ({PCBranch_E, aluResult_E, writeData_E, zero_E_aux} !== expected_output) begin
			$display ("---------------------------------------------------------------\n");
			$display (" Error en linea : %d  													  \n", vector_num);
			$display (" Linea : %h                                                    \n", testvectors[vector_num]);
			$display (" Input : %h, AluSrc : %s       										  \n", {AluControl, PC_E, signImm_E, readData1_E, readData2_E},
																													 (AluSrc === 1) ? "activado" : "desactivado");
			if (PCBranch_E !== expected_output [195:132]) begin
				$display (" PCBranch_E ERROR : se esperaba %h, se recibio %h			  \n", expected_output [195:131], PCBranch_E);
				error += 1;
			end
			if (aluResult_E !== expected_output [131:68]) begin
				$display (" aluResult ERROR : se esperaba %h, se recibio %h			     \n", expected_output [131:67], aluResult_E);
				error += 1;
			end
			if (writeData_E !== expected_output [67:4]) begin
				$display (" PCBranch_E ERROR : se esperaba %h, se recibio %h			  \n", expected_output [67:4], writeData_E);
				error += 1;
			end
			if (zero_E_aux !== expected_output [3:0]) begin
				$display (" zero ERROR : se esperaba %h, se recibio %h			        \n", expected_output [3:0], zero_E_aux);
				error += 1;
			end
			$display ("---------------------------------------------------------------\n\n");
		end
		vector_num += 1;
		if (vector_num === `testvector_size) begin
			$display ("%d tests completados con %d errores \n", vector_num, error);
			$stop;
		end
	end
	
endmodule
