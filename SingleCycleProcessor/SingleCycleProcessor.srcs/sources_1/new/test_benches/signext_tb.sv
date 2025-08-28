// Signext Testbench module
module signext_tb();

    logic [31:0] a;
    logic [63:0] y;

    logic [31:0] instructions[0:12] = '{
        {32'b11111000010_01110001100_01001_10110},    // LDUR positivo
        {32'b11111000010_11110001100_01001_10110},    // LDUR negativo
        {32'b11111000000_01110001100_01001_10110},    // STUR positivo
        {32'b11111000000_11110001100_01001_10110},    // STUR negativo
        {32'b10110100001_1110001111111010_10110},     // CBZ positivo
        {32'b10110100101_1110001111111010_10110},     // CBZ negativo
        {32'b10010001001_10000000000_00001_00000},    // ADDI (I)
        {32'b11010001001_10000000000_00001_00000},    // SUBI (I)
        {32'b10110001001_10000000000_00001_00000},    // ADDIS (I)
        {32'b11110001001_10000000000_00001_00000},    // SUBIS (I)
        {32'b10001011000_11011_001101_10111_01001},   // ADD (R)
        {32'b11010010101_00_01110010111011_01001},    // MOVZ (IM)
        {32'b10010110110_111010001110010111011}       // BL (B)
    };
    logic [63:0] yexpected[0:12] = '{
        {{55{instructions[0][20]}}, instructions[0][20:12]}, // LDUR positivo
        {{55{instructions[1][20]}}, instructions[1][20:12]}, // LDUR negativo
        {{55{instructions[2][20]}}, instructions[2][20:12]}, // STUR positivo
        {{55{instructions[3][20]}}, instructions[3][20:12]}, // STUR negativo
        {{45{instructions[4][23]}}, instructions[4][23:5]},  // CBZ positivo
        {{45{instructions[5][23]}}, instructions[5][23:5]},  // CBZ negativo
        64'b0, // ADDI
        64'b0, // SUBI
        64'b0, // ADDIS
        64'b0, // SUBIS
        64'b0, // ADD
        64'b0, // MOVZ
        64'b0  // BL
      };

    int errors = 0;

  /*
  Instancia del Sign Extend
  -----------------------
  */
    signext dut(
      .a(a),
      .y(y)
    );
  /*
  ______________________
  */

    initial begin
        for (int i = 0; i < 13; ++i) begin
            #1ns; a = instructions[i]; #1ns;
            if (y != yexpected[i] ) begin
                $display("Error");
                $display("output = %h, (expected %h)", y, yexpected[i]);
                errors++; #1ns;
            end
            else begin
                $display("Test %d passed succesfully", i+1);
            end
        end
        $display("%d tests completed with %d errors", 13, errors);
        $stop;

    end
endmodule
