// Flopr Testbench module

`timescale 1ns/1ps

module flopr_tb();

  parameter N = 32;
  logic clk, reset;
  logic [N-1:0] d;
  logic [N-1:0] q;
  logic [N-1:0] qexp;
  int i = 0;
  int errors = 0;
  parameter int tests = 10;
  
  //Inicialización con 10 números distintos
    logic [N-1:0] dvectors [0:9] = {
        'b0000, 'b0001, 'b0010, 'b0011, 'b0100,
        'b0101, 'b0110, 'b0111, 'b1000, 'b1111
    };
  
  //Salida esperada
    logic [N-1:0] qexpected [0:9] = {
        'b0000, 'b0001, 'b0010, 'b0011, 'b0100,
        'b0101, 'b0110, 'b0111, 'b1000, 'b1111
    };

  //Genero señal de clock de 10ns
  always begin
		clk = 0; #5;
    clk=1; #5;
	end

  //Inicializacion de las variables importantes
  initial begin
    reset = 1;
    @(posedge clk); // esperar un ciclo de clock
    @(posedge clk); // otro ciclo
    reset = 0;
  end

  /*
  Instancia del Flip Flop de 32 bits
  -----------------------
  */
  flopr #(.N(N)) dut(
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
  );
  /*
  ______________________
  */


  //Seteo entradas
	always @ (posedge clk) begin
		d = dvectors[i];
    qexp = qexpected[i];
    #1ns;
	end
		
	always @ (negedge clk) begin
    if (!reset) begin
      if(q != qexp) begin
        $display("------------------------\n");
        $display("\nError: input = %d", {dvectors[i]});
        $display("Output = %b (%b expected)",q, qexp);
        $display("------------------------\n");
        errors++;
      end
      i++;
      if(i == tests) begin
        $display("%d test completed with %d errors",i, errors);
        $stop;
      end
    end
	end

endmodule
