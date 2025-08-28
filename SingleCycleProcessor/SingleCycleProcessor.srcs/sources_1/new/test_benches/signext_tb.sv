// Signext Testbench module
module signext_tb();

    logic [31:0] a;
    logic [31:0] instr_test[0:7] = '{
        {32'b11111000010_011100011_00_01001_10110}, // LDUR positivo
        {32'b11111000010_111100011_00_01001_10110}, // LDUR negativo
        {32'b11111000000_011100011_00_01001_10110}, // STUR positivo
        {32'b11111000000_111100011_00_01001_10110}, // STUR negativo
        {32'b10110100001_111000111111101010110}, // CBZ positivo
        {32'b10110100110_111100011111110100000}, // CBZ negativo
        {32'b10001011000_110110011011011101001}, // ADD (R)
        {32'b11010010101_000111001011101101001}  // MOVZ (IM)
    };
    logic [63:0] y;
    logic [63:0] yexp[0:7] = '{
                {{55{instr_test[0][20]}}, instr_test[0][20:12]}, // LDUR positivo
                {{55{instr_test[1][20]}}, instr_test[1][20:12]}, // LDUR negativo
                {{55{instr_test[2][20]}}, instr_test[2][20:12]}, // STUR positivo
                {{55{instr_test[3][20]}}, instr_test[3][20:12]}, // STUR negativo
                {{45{instr_test[4][23]}}, instr_test[4][23:5]},  // CBZ positivo
                {{45{instr_test[5][23]}}, instr_test[5][23:5]},  // CBZ negativo
                64'b0,                         // ADD
                64'b0                         // MOVZ
    };

    int errors = 0;

    // Device under test instance
    signext dut(a,y);

    initial begin
        for (int i = 0; i < 8; ++i) begin
            #1ns; a = instr_test[i]; #1ns;
            if (y != yexp[i] ) begin
                $display("Error");
                $display("output = %h, (expected %h)", y, yexp[i]);
                errors++; #1ns;
            end
            else begin
                $display("Test %d passed succesfully", i+1);
            end
        end
        $display("%d tests completed with %d errors", 8, errors);
        $stop;

    end
endmodule
