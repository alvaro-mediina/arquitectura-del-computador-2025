`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2025 05:04:36 PM
// Design Name: 
// Module Name: flopr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flopr
    #(parameter N = 64)
    (
    input logic clk,
    input logic reset,
    input logic [N-1:0] d,
    output logic [N-1:0]q
    );
    always_ff @( posedge clk, posedge reset )
      if(reset) q <= '0;
      else q <= d;
endmodule
