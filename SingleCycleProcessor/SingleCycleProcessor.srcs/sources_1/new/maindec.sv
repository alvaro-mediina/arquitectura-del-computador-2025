module maindec (
		input logic [10:0] Op,
		output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite,
		             MemRead, MemWrite, Branch,
		output logic [1:0] ALUOp
	       );
					
	always_comb begin 
		casez (Op) 
			11'b111_1100_0010: // LDUR
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {'0,'1,'1,'1,'1,'0,'0, 2'b00};
			11'b111_1100_0000: //STUR 
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {'1,'1,'0,'0,'0,'1,'0, 2'b00};
			11'b101_1010_0???: // CBZ
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {'1,'0,'0,'0,'0,'0,'1, 2'b01};
			
			// R-format
			11'b100_0101_1000, 11'b110_0101_1000, 11'b100_0101_0000, 11'b101_0101_0000: //ADD, SUB, AND, ORR
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {'0,'0,'0,'1,'0,'0,'0, 2'b10};
			
			11'b110_1000_100?, 11'b100_1000_100?: // ADDI, SUBI
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {'0,'1,'0,'1,'0,'0,'0, 2'b10};
			
			default: 
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {'0,'0,'0,'0,'0,'0,'0, 2'b00};
		endcase
	end
endmodule
