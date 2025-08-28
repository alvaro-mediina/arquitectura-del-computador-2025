// Testbench fetch module
module fetch_tb();

   parameter N = 64;
   logic PCSrc_F, clk, reset;
   logic [N-1:0] PCBranch_F;
   logic [N-1:0] imem_addr_F;
    
	logic [N-1:0] last_imem_addr; // Saves PC value for comparation
	int cycle, errors;
    
	fetch #(64) dut(PCSrc_F, clk, reset, PCBranch_F, imem_addr_F);

	always begin 
	  clk = '1; #5; clk = ~clk; #5;
	end

	initial begin
		errors = 0;
		cycle = 0;
		last_imem_addr = 64'd0; 
		reset = '1; 
		PCSrc_F = '0;
		PCBranch_F = 64'd100;  // Random value
	end

	always @(posedge clk) begin
		cycle = cycle + 1;
		
		// Activate reset after 5 cycles
		if (cycle == 6) begin
			reset = '0;  
		end
		
		// Change mux input after 10 cycles
		if (cycle == 11) begin
			PCSrc_F = '1; 
		end
	end

	// Verify PC actualizations
	always @(negedge clk) begin
		
		// PC reset
		if (cycle == 6) begin
			if (imem_addr_F !== 64'd0) begin
				$display("Error during reset.");
				$display("PC_out = %d, PC_exp = %d", imem_addr_F, 64'd0);
				errors = errors + 1;
			end 
			last_imem_addr = imem_addr_F; 
		end
		
		// PC increases
		if (cycle > 6 && cycle < 10) begin
			if (imem_addr_F !== last_imem_addr + 64'd4) begin
				$display("Error increasing PC.");
				$display("PC_out = %d, PC_exp = %d", imem_addr_F, last_imem_addr + 64'd4);
				errors = errors + 1;
			end 
			last_imem_addr = imem_addr_F;  
		end
		
		// PCBranch_F input
		if (cycle == 12) begin
			if (imem_addr_F !== PCBranch_F) begin
				$display("Error al tomar el valor de PCBranch_F");
				$display("PC_out = %d, PC_exp = %d", imem_addr_F, PCBranch_F);
				errors = errors + 1;
			end 
		end
		// End simulation 
		if (cycle == 13) begin
			$display("ENDED WITH %d ERRORS", errors);
			$stop;
		end
	end
endmodule
