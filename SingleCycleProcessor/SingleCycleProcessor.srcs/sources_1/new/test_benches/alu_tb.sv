// Testbench alu module
module alu_tb();
    
    logic [63:0] a, b;
    logic [3:0] ALUControl;
    logic [63:0] result;
    logic zero;
	 
	 localparam int tests = 23; 
	 logic [63:0] result_exp;
	 logic zero_exp;
	 int errors;
	 
    // TESTS FORMAT: {a, b, ALUControl, result_exp, zero_exp}
    logic [196:0] testvectors [0:tests-1] = '{
                // 2_POSITIVOS	 
                {64'd3, 64'd1, 4'b_0000, 64'd1, 1'b0},  // &
                {64'd1, 64'd1, 4'b_0001, 64'd1, 1'b0},  // |
                {64'd1, 64'd1, 4'b_0010, 64'd2, 1'b0}, // +
                {64'd2, 64'd1, 4'b_0110, 64'd1, 1'b0}, // -
                {64'd1, 64'd3, 4'b_0111, 64'd3, 1'b0}, // pass b

                // 2_NEGATIVOS
                {-64'd3, -64'd1, 4'b_0000, -64'd3, 1'b0}, // &
                {-64'd1, -64'd1, 4'b_0001, -64'd1, 1'b0}, // |
                {-64'd1, -64'd1, 4'b_0010, -64'd2, 1'b0}, // +
                {-64'd2, -64'd4, 4'b_0110, 64'd2, 1'b0}, // -
                {-64'd1, -64'd3, 4'b_0111, -64'd3, 1'b0}, // pass b

                // 1 POSITIVO 1 NEGATIVO
                {64'd3, -64'd1, 4'b_0000, 64'd3, 1'b0}, // &
                {64'd1, -64'd1, 4'b_0001, -64'd1, 1'b0}, // |
                {-64'd1, 64'd1, 4'b_0010, 64'd0, 1'b1}, // +
                {64'd2, -64'd1, 4'b_0110, 64'd3, 1'b0}, // -
                {64'd1, -64'd3, 4'b_0111, -64'd3, 1'b0}, // pass b

                // Overflow 
                {64'h7FFFFFFFFFFFFFFF, 64'd1, 4'b0010, 64'h8000000000000000, 1'b0},

                // testing zero output
                {64'd2, 64'd1, 4'b_0000, 64'd0, 1'b1},  // &
                {64'd0, 64'd0, 4'b_0001, 64'd0, 1'b1},  // |
                {-64'd2, 64'd2, 4'b_0010, 64'd0, 1'b1}, // +
                {-64'd1, -64'd1, 4'b_0110, 64'd0, 1'b1}, // -
                {64'd2, 64'd0, 4'b_0111, 64'd0, 1'b1}, // pass b
					 
		// Testing default value 
		{64'd2, 64'd0, 4'b_0101, 64'd0, 1'b1}, // Other ALUControl value
		{64'd2, 64'd0, 4'b_1000, 64'd0, 1'b1} // Other	ALUControl value				 
					 
    };

    alu dut (a, b, ALUControl, result, zero);

    initial begin
        #1ns;
        errors = 0;
        for (int i=0; i < tests; ++i) begin 
            #1ns;
            {a, b, ALUControl, result_exp, zero_exp } = testvectors[i]; #1ns;

            if (result !== result_exp || zero !== zero_exp) begin
                $display("Error");
                $display("a = %d, b = %d, ALUControl = %b", a, b, ALUControl);
                $display("result = %d, (expected %d)", result, result_exp);
                $display("zero = %b, (expected %b)", zero, zero_exp);
                errors++; #1ns;
            end
            else begin
                $display("Test %d passed succesfully", i);
            end
        end 
        $display("%d tests completed with %d errors", tests, errors);
        $stop;
    end 
	 
endmodule	
	 
