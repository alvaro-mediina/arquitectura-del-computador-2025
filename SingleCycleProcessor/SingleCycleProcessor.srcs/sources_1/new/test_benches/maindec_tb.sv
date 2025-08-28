module maindec_tb();

	logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, errors;
	logic [1:0] ALUOp;
	logic [10:0] Op;

	logic [10:0] op_tests [0:7] = '{
							{11'b111_1100_0010}, // LDUR
							{11'b111_1100_0000}, // STUR
							{11'b101_1010_0000}, // CBZ
							{11'b100_0101_1000}, // ADD
							{11'b110_0101_1000}, // SUB
							{11'b100_0101_0000}, // AND
							{11'b101_0101_0000},  // ORR
							{11'b110_1100_1100}  // Otro
		};
	logic [8:0] exp_output [0:7] = '{
							{'0,'1,'1,'1,'1,'0,'0, 2'b00}, // LDUR
							{'1,'1,'0,'0,'0,'1,'0, 2'b00}, // STUR
							{'1,'0,'0,'0,'0,'0,'1, 2'b01}, // CBZ
							{'0,'0,'0,'1,'0,'0,'0, 2'b10}, // ADD
							{'0,'0,'0,'1,'0,'0,'0, 2'b10}, // SUB
							{'0,'0,'0,'1,'0,'0,'0, 2'b10}, // AND
							{'0,'0,'0,'1,'0,'0,'0, 2'b10}, // ORR
							{'0,'0,'0,'0,'0,'0,'0, 2'b00} // default						
	};
	
	maindec dut(Op, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
	
	initial begin
		#1ns; errors = 0; #1ns;
		for (int i=0; i<8; ++i) begin
			Op = op_tests[i]; #1ns;
		
			if ( {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} != exp_output[i]) begin
				$display("Error");
				$display("OP = %b", op_tests[i]);
				$display("output = %b, (expected %b)", {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp}, exp_output[i]);
			end
			else begin
				$display("Test %d passed succesfully", i);
         end
		end 
	  
		$display("%d tests completed with %d errors", 8, errors);
		$stop;	
	end
endmodule
					
