// ALU CONTROL DECODER

module aludec_tb ();
    logic [10:0] funct;  
	logic [1:0]  aluop;
	logic [3:0] alucontrol, aluc_exp;  	
    logic errors;
    

    logic [16:0] tests [0:8] = '{
        {11'b0000_0000_000, 2'b00, 4'b0010},
        {11'b1111_1111_000, 2'b01, 4'b0111},
        
        {11'b1000_1011_000, 2'b10, 4'b0010},
        {11'b1100_1011_000, 2'b10, 4'b0110},
        {11'b1000_1010_000, 2'b10, 4'b0000},
        {11'b1010_1010_000, 2'b10, 4'b0001},

        {11'b1001_0001_000, 2'b10, 4'b0010},
        {11'b1101_0001_001, 2'b10, 4'b0110},

        {11'b0000_0000_111, 2'b11, 4'b0000}

    };

    aludec inst (.funct(funct), .aluop(aluop), .alucontrol(alucontrol));					

    initial begin 
        #1ns; errors = 0; #1ns;
        
        for (int i=0; i<9; i++) begin
            {funct, aluop, aluc_exp} = tests[i]; #1ns;
            if (alucontrol != aluc_exp) begin 
                errors = errors + 1;
                $display("Test %d failed", i);
                $display("Expected: %b, Got: %b", aluc_exp, alucontrol);
            end
        end 

        $display("%d tests completed with %d errors. \n", 9, errors);
		$stop;	
    end
endmodule
