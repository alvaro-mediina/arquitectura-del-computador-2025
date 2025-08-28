module execute #(parameter N=64)
					(input logic AluSrc,
                input logic [3:0] AluControl,
					 input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
					 output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E, 
					 output logic zero_E);
	
	logic [N-1:0] sl2Result;
	logic [N-1:0] ALUb;
	
	sl2 sl2function(.a(signImm_E), .y(sl2Result));
	adder adderfunction(.a(PC_E), .b(sl2Result), .y(PCBranch_E));
	mux2 mux2function(.d0(readData2_E), .d1(signImm_E), .s(AluSrc), .y(ALUb));
	alu alufunction(.a(readData1_E), .b(ALUb), .ALUControl(AluControl), .result(aluResult_E), .zero(zero_E));
	
	assign writeData_E = readData2_E;
	
endmodule
