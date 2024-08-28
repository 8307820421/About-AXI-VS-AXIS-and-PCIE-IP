`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2024 17:46:16
// Design Name: 
// Module Name: round_robin
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

module round_robin(
   input wire axis_clk,
   input wire axis_reset,
   input wire req_1,
   input wire req_2,
   
   // output button
   output reg gnt_1,
   output reg gnt_2

    );
    
   // state aasignment
   localparam idle = 2'b00;
   localparam s1 = 2'b01;
   localparam s2 = 2'b10;
     
  // state decleration
  reg [1:0] state = idle, next_state = idle;
  
  // logic for reset
  
  always @ (posedge axis_clk) 
  begin
    if (axis_reset == 1'b1) 
    state <= idle;
    
    else 
    state <= next_state;
  end
  
  // logic for request fsm  state manamgment based upon request priority// act as decoder logic// based upon inpur
  
  always @ (*)
  begin
  case (state)
  
   idle : begin
     if (req_1)
     next_state = s1;
     else if (req_2) 
     next_state = s2;
     else
     next_state = idle;
   end
   
  
   
   s1 :begin
   if (req_2) 
   next_state = s2;
   else if (req_1)
   next_state = s1;
   else
   next_state = idle;
   end
   
   s2 : begin
   if (req_1)
   next_state = s1;
   else if (req_2)
   next_state = s2;
   
   else
   next_state = idle;
   end
   
   default : begin
   next_state = idle;
   end
   
  endcase
  
  end
  
  // fsm for output  based upon request state management // output based upon priority request
  
  always @ (*) 
  begin
  
  case (state) 
  idle :begin
    gnt_1 = 1'b0;
    gnt_2 = 1'b0;
  end
  
  s1 : begin
  gnt_1 = 1'b1;
  gnt_2 = 1'b0;
  end
  
  s2 : begin
  gnt_1 = 1'b0;
  gnt_2 = 1'b1;
  end
  
  default : begin
  gnt_1 = 1'b0;
  gnt_2= 1'b0;
  end
  endcase
  end

  
endmodule
