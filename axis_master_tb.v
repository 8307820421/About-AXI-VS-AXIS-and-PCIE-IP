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


// logic developed by me: This is AXIS based master not realted to BRAM and other things // correct test bench.

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


   integer i;
   always #10 axis_clk = ~axis_clk;
   
   // stimuli for input reg
   initial begin
 
   t_valid = 1'b0;
   t_data =  0;
   t_last = 1'b0;
   reset = 1'b1;
   t_keep = {keep_width{1'b0}};
   repeat(5) @(posedge axis_clk) ;
    
    // stimuli for high reset and t_valid
    reset = 1'b0; 
    for (i = 0; i<mem_size_depth ; i= i+1) // for indexing based on that data will go
    begin
    @(posedge axis_clk); // clk for loop
    
    // tvalid
    t_valid = 1'b1;
    t_keep[i] = {keep_width{1'b1}};
    t_data = $urandom;
    bram_dout = bram_data;
     
     //@(posedge axis_clk);  // clk for tvalid//tdta // this clock will lead to t_ready high for short time hence adjust the logic if required//
    
    end 
   @(posedge axis_clk); // clk for entire loop
    
    t_last = 1'b1;
    @(posedge axis_clk); // clk for t_last
    
    t_last = 0;
    t_valid = 0;
    @(posedge axis_clk); // clk for deasserted the tlast and tvalid
      $finish;
  
   end
endmodule



// here there is another approach where address counter is incremented up to mem_size but at that time with one posedge only 512 bit data transmitted w.r.t i (index).
// put this inside the initial block.

//// Clock generation
////initial axis_clk = 1'b1;
//always #10 axis_clk = ~axis_clk;

//integer i;
// // Stimulus generation
//initial begin
//// Initialize inputs
//reset = 1;
//t_valid = 1'b0;
//t_last = 1'b0;
//t_keep = {keep_width{1'b0}};
//repeat(10) @(posedge axis_clk);

 
// for (i = 0; i<= (mem_size_depth-1) ; i= i+1) begin

//@(posedge axis_clk);
//reset = 0;
//t_valid = 1'b1;
//t_keep[i] = {keep_width{1'b1}} ; // based upon t_keep validity
//t_data = $random;
//t_last = 1'b0;


//@(posedge t_ready);
//t_last = 1'b0;

//@(negedge t_ready);
//t_valid= 1'b0;
//t_last = 1'b1;



//end
 
 
//end 

