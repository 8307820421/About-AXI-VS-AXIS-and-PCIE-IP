`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2024 11:48:04
// Design Name: 
// Module Name: axis_slave_tb
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

  /* this is the test bench for slave
  and this can used for slave by adding some logic  */

`define   clock_period 10;

module axis_slave_tb();
//  Input pins

    reg         s_axis_clk = 0;
    reg         s_axis_resetn;
    reg         s_axis_tvalid;
    reg  [7:0]  s_axis_tdata;
    reg         s_axis_tlast;
   
   // output pins
   wire s_axis_tready;
   wire [7:0]s_axis_dout;
   
 
      // Instantiate the axis_s module
    axis_slave uut (
        .s_axis_clk(s_axis_clk),
        .s_axis_resetn(s_axis_resetn),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tlast(s_axis_tlast),
        .s_axis_tready(s_axis_tready),
        .s_axis_dout(s_axis_dout)
    ); 
   
   integer i;
   always #10 s_axis_clk = ~s_axis_clk;
   
   // stimuli for input reg
   initial begin
 
   s_axis_tvalid = 1'b0;
   s_axis_tdata =  0;
   s_axis_tlast = 1'b0;
   s_axis_resetn = 1'b0;
   repeat(5) @(posedge s_axis_clk) ;
    
    // stimuli for high reset and t_valid
    s_axis_resetn = 1'b1; 
    for (i = 0; i<10 ; i= i+1) // for indexing based on that data will go
    begin
    @(posedge s_axis_clk); // clk for loop
    
    // tvalid
    s_axis_tvalid = 1'b1;
    s_axis_tdata = $urandom;
    @(posedge s_axis_clk);    // clk for tvalid//tdta
    end 
    @(posedge s_axis_clk); // clk for entire loop
    
    s_axis_tlast = 1'b1;
    @(posedge s_axis_clk); // clk for t_last
    
    s_axis_tlast = 0;
    s_axis_tvalid = 0;
    @(posedge s_axis_clk); // clk for deasserted the tlast and tvalid
      $finish;
  
   end
   
   
endmodule
