`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2024 11:33:20
// Design Name: 
// Module Name: axis_slave
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


module axis_slave(
   input wire       s_axis_clk,
   input wire       s_axis_resetn,
   input wire       s_axis_tvalid,
   input wire [7:0] s_axis_tdata,
   input wire       s_axis_tlast,
   
   // output pins
   
   output wire s_axis_tready,
   output wire [7:0]s_axis_dout

    );
    
// state assignment logic
localparam idle  = 2'b00;
localparam rx  = 2'b01; // controlled through the master input pins
localparam last_byte = 2'b10;
reg [2:0] state = idle, next_state = idle;


//  reset logic
always @ (posedge s_axis_clk) 
begin
  if (s_axis_resetn == 1'b0) 
     state <= idle;
  else 
  state <= next_state;
  
end

// fsm for slave

always @ (*)
begin
 case(state)
 
 idle : begin
 
   if (s_axis_tvalid == 1'b1) 
      next_state = rx;
   else
   next_state = idle;
   
 end
 
 rx : begin
 
  if ((s_axis_tlast == 1'b1) && (s_axis_tvalid == 1'b1))
      next_state = idle;
      
  else if ((s_axis_tlast == 1'b0) && (s_axis_tvalid == 1'b1))
        next_state = rx;
        
  else 
       next_state = idle;
 end
 
 default : next_state = idle;
 
 endcase
 
end

// logic  for the output signals

assign s_axis_tready = (state  == rx);
assign s_axis_dout =   (state == rx)? s_axis_tdata : 8'h00 ;
endmodule
