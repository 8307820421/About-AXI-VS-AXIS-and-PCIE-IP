`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2024 12:41:55
// Design Name: 
// Module Name: axis_master
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

/*
Familiar with the tready, tdata, tlast,tvalid AXIS signals
*/
module axis_master(

// input signal as per problem statement
input wire m_axis_clk,
input wire m_axis_rstn,
input  wire [7:0] din,
input wire new_data,
input wire m_axis_tready,

// output signal as per problem statement
output wire m_axis_tvalid,
output wire [7:0]m_axis_tdata,
output wire m_axis_tlast

    );
    
// state assignment logic
localparam idle = 1'b0;
localparam tx = 1'b1;
reg [1:0] state = idle, next_state = idle;
// to keep the track of data
reg [2:0] count;

// always block logic for reset sequential non- block (<= )

always @ (posedge  m_axis_clk) 
begin
    if (m_axis_rstn == 1'b0) 
    state <= idle;
    else 
    state <= next_state;
    end




// always logic for counter // sequential non - block (<=)
always @ (posedge m_axis_clk)
begin
      if (state == idle) 
         count <= 0;
      else if (state == tx && count != 3 && m_axis_tready == 1'b1)  
       count <= count + 1;
    else 
    count <= count;
 end


// always logic for FSM or state assignment // blocking // combinational (=) 

always @ (*) 
begin
case (state) 

    idle : 
    begin
    
         if (new_data == 1'b1) 
          next_state = tx;
         else
         next_state = idle;
     
     end
     
    tx:
       begin
       
         if(m_axis_tready == 1'b1)
          begin                    
             if(count != 3)
              next_state  = tx;
                else
                  next_state  = idle;
                end
                
                else
                   begin
                    next_state  = tx;
                  end
                   
                end
               
               default: next_state = idle;
               
               endcase         
     end // combination logic for state assignment end
     
 assign m_axis_tdata   = (m_axis_tvalid) ? din*count : 0;   // tdata logic
 assign m_axis_tlast   = (count == 3 && state == tx)    ? 1'b1 : 0; // tlast logic for last byte
 assign m_axis_tvalid  = (state == tx ) ? 1'b1 : 1'b0; // tvalid logic
 
endmodule


