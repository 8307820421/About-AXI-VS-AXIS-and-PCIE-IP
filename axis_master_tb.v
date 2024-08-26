`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2024 14:14:41
// Design Name: 
// Module Name: axis_master_tb
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


// logic developed by me: This is AXIS based master not realted to BRAM and other things.

module axis_master_tb();
// input signal as per problem statement
reg m_axis_clk = 0;
reg m_axis_rstn;
reg [7:0] din;
reg new_data;
reg m_axis_tready;

// output signal as per problem statement
 wire m_axis_tvalid;
 wire [7:0]m_axis_tdata;
 wire m_axis_tlast;
 
 
 // instantiation or device under test
 
 axis_master dut(
.m_axis_clk(m_axis_clk),
.m_axis_rstn(m_axis_rstn),
.din( din ),
.new_data(new_data),
.m_axis_tready(m_axis_tready),

// output signal as per problem statement
 .m_axis_tvalid (m_axis_tvalid),
 .m_axis_tdata(m_axis_tdata),
 .m_axis_tlast(m_axis_tlast)
 );
 
 
// adding stimulus for clock


always #10 m_axis_clk = ~m_axis_clk;

integer i;

// stimuli for data transfer logic
initial begin

m_axis_rstn = 0;
repeat(10)@(posedge m_axis_clk)

 for (i= 0 ; i<5 ; i= i+1) // counter logic // for each trransfer having 4 byte of data// with respect to i with in five clock pulse the tdata will be updated based upon counter
begin                      // as counter is counting up to 3 byte hence when it will last then t_last asserted or active and t_valid after this deasserted as well as tready.

@(posedge m_axis_clk)

 m_axis_rstn= 1;
 m_axis_tready = 1'b1;
 new_data = 1; // oone bit for enabling the new data 
 din = $random;
 
 @(negedge m_axis_tlast) 
 m_axis_tready = 1'b0;
   
end

end
endmodule


