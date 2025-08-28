`timescale 1 ns / 100 ps
`define clk_freq 5 

module regfile_tb();

	logic [4:0] ra1, ra2, wa3;
	logic [63:0] wd3, rd1, rd2;
	logic we3, clk;

	logic [63:0] registers [31:0];
	logic [63:0] prev_registers [31:0];
	logic [31:0] error;
	logic initialized;
	
	regfile dut (ra1, ra2, wa3, wd3, we3, clk, rd1, rd2);

	always begin
		clk = 1; #`clk_freq;
		clk = 0; #`clk_freq;
	end

	initial begin
		
		wd3 = 64'b0;
		wa3 = 5'b0;
		we3 = 64'b0;
		
		initialized = 0;
		error = 0;
		
		// confirmacion de incializacion
		for (int i = 0; i < 30; i += 2) begin
			
			ra1 = i;
			ra2 = i+1; #`clk_freq;
			
			if (ra1 !== rd1) begin
				error = error + 1;
				$display ("ERROR: rd1 deberia ser: %b, no %b \n", ra1, rd1);
			end
			if (ra2 !== rd2) begin
				error = error + 1;
				$display ("ERROR: rd2 deberia ser: %b, no %b \n", ra1, rd2);
			end
			
			//guardo los registros para despues
			registers [i] = rd1;
			registers [i+1] = rd2; 
			
		end
		
		ra1 = 30;
		ra2 = 31; #`clk_freq;
		
		if (ra1 !== rd1) begin
				error = error + 1;
				$display ("ERROR: rd1 deberia ser: %b, no %b \n", ra1, rd1);
			end
			
		if (rd2 !== 64'b0) begin
			error = error + 1;
			$display ("ERROR: rd2 deberia ser: %b, no %b \n", ra1, rd2);
		end
		
		prev_registers = registers;
		initialized = 1;
		
		#50 we3 = 1;
		wd3 = 64'd32;	// para que no coincida registers[0] con wd3
		
		#200 $display ("errores totales: %d\n", error);
		$stop;

	end
	
	always @(posedge clk) begin
		#2;
		if (initialized) begin
			if (we3 === 0) 
				for (int i = 0; i < 32; i++) begin		// controla que ningun valor haya cambiado durante el flanco 
					if (prev_registers[i] !== registers[i]) begin
						$display ("ERROR: el registro %d ha cambiado, deberia ser: %b, pero es %b \n", i, prev_registers[i], registers[i]); 
						error = error + 1;
					end
				end
			else begin
				wd3 = wd3 + 1;
				ra1 = wa3;
			end
		end
	end
		
	always @(negedge clk) begin
		#2;
		if (initialized) begin
			if (we3 === 1) begin
				registers[wa3] = rd1;
				if (registers[wa3] === prev_registers[wa3]) begin		// chequea que haya cambiado el valor de registers [wa3] a wd3
					$display ("ERROR: el registro %d deberia haber cambiado, pero no lo hizo (%b y %b) \n", wa3, rd1, prev_registers[wa3]);
					error = error + 1;
				end
				prev_registers[wa3] = registers[wa3];
				wa3 = (wa3 + 1) % 32;			// para alternar entre registros
			end
		end
	end		

endmodule 