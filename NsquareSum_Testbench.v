
module Testbench;
  reg [2:0] N;
  reg N_valid, Clk, Rst,ack;
  wire [7:0] sum_out;
  wire sum_valid;

  top_module DUT(N, Clk, Rst, ack, N_valid, sum_out, sum_valid);
  
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars(0, DUT);
    
    Clk = 0;
    forever #10 Clk = ~Clk;
  end
  
  initial begin
    Rst = 0;
    #10
    N_valid = 1;
    N = 4;
    #15
    Rst = 1;
    #10
    Rst = 0;
    #10
    N_valid = 1;
    #20
    N_valid = 0;
    #300
    ack = 1;
    #10
    ack = 0;
    #10
    Rst = 0;
    #10
    N_valid = 1;
    N = 3;
    #15
    Rst = 1;
    #10
    Rst = 0;
    #10
    N_valid = 1;
    #20
    N_valid = 0;
   end
  
  initial begin
    $monitor($time);
    #600
    $finish;
  end
endmodule
SS
