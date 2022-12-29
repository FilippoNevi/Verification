//including interface and testcase files
`include "fsmInterface.sv"
`include "test.sv"
`timescale 1ns/1ns
`define N 10 // delay of beverages delivering
`define M 20 // delay of change delivering

module tbench_top;
  logic clk, rst;
  reg[15:0] coin_in;
  reg[1:0] button_in;
  reg[1:0] beverage_out;
  reg[15:0] change_out;
  
  always #5 clk =~clk;
  
  initial begin
    reset = 1;
    clk = 0;
    #5 reset =0;
  end
  
  /* Instantiate device under test
  Fsm fsm(.clk(clk),
          .rst(rst),
          .coin_in(coin_in),
          .button_in(button_in),
          .change_out(change_out),
          .beverage_out(beverage_out));
  */
         
  //creating an instance of interface to connect DUT and testcase
  fsm_intf intf(clk,reset);
  
  //testcase instance, interface handle is passed to test as an argument
  test t1(intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  Fsm DUT (intf.dut);
  
  //enabling the wave dump
  initial begin 
    $dumpfile("fsm.vcd");
    $dumpvars(0, tbench_top, intf);
  end
endmodule
