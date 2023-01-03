`include "fsmInterface.sv"
`include "test.sv"
`timescale 1ns/1ns

module tbench_top;
  logic clk, rst;
  reg[15:0] coin_in;
  reg[1:0] button_in;
  reg[1:0] beverage_out;
  reg[15:0] change_out;
  
  always #5 clk =~clk;
  
  initial begin
    rst = 1;
    clk = 0;
    #5 rst =0;
  end
  
  fsm_intf intf(clk,rst);
  test t1(intf);
  Fsm DUT (intf.dut);
  
  initial begin 
    $dumpfile("fsm.vcd");
    $dumpvars(0, tbench_top, intf);
  end
endmodule
