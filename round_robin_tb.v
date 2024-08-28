`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2024 17:13:54
// Design Name: 
// Module Name: round_robin_tb
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


/* here we learned about the round robin arbiter that is the application of AXIS stream protocol that help to 
   understand the request or decoder logic based upon request priority and which request have highest priority 
   also done based upon the logic.
   This application plays a crucial role for performing the any operation based upon the request or interrupt.
   when both the request are high then it grant will provide based upon the who request first..
*/

`define clk_period 10;
module round_robin_tb();

/// input pins as reg
   reg  axis_clk = 0;
   reg  axis_reset;
   reg  req_1;
   reg  req_2;
   
 // output pins as 
 wire gnt_1;
 wire gnt_2;
 
 
 
 // instantiating the pins
 /// input pins as reg
 round_robin dut(
    .axis_clk(axis_clk),
    .axis_reset(axis_reset),
    .req_1(req_1),
    .req_2(req_2),
   
 // output pins as 
   .gnt_1(gnt_1),
   .gnt_2(gnt_2)
  ); 
   
 //  adding stimuli for clk
 
 always #10  axis_clk = ~ axis_clk;
 
 // 
 initial begin
 axis_reset = 1'b1;
 repeat (5) @(posedge axis_clk);
 
 axis_reset = 1'b0;
 req_1 = 1'b1;
 req_2 = 1'b0;
 @(posedge axis_clk);
 
 req_1 = 1'b0;
 req_2 = 1'b1;
 @(posedge axis_clk);
 
 req_1 = 1'b1;
 req_2 = 1'b1;
 repeat (5) @(posedge axis_clk);
 
 
 $stop;
 end
   
endmodule

