`timescale 1ns/1ns
`define N 10 // Delay of beverages delivery
`define M 20 // Delay of change delivery

module test;
  logic clk, rst;
  reg[15:0] coin_in;
  reg[1:0] button_in;
  reg[1:0] beverage_out;
  reg[15:0] change_out;
  
  Fsm fsm(.clk(clk),
          .rst(rst),
          .coin_in(coin_in),
          .button_in(button_in),
          .change_out(change_out),
          .beverage_out(beverage_out));
          
  always
    begin
      #5 clk =~clk;
    end

  initial begin
    $dumpfile("fsm.vcd");
    $dumpvars(0,test);
    clk = 0;
    rst = 1;
    button_in = 00; // Define the signal coming from the buttons
    #10;
    rst = 0;
    #10;
    coin_in = 200;
    #10;
    coin_in = 0;
    #10;
    coin_in = 20;
    #10;
    coin_in = 0;
    #20;
    button_in = 10; // Anomaly: Illegal button code
    #`N
    #10;
    button_in = 00;
    #30;
    button_in = 11;
    #`N
    #10;
    button_in = 00;
    #40;
    button_in = 11;
    #`N
    #10;
    button_in = 00;
    #50;
    button_in = 01;
    #`N
    #10;
    button_in = 00;
    #40;
    button_in = 01;
    #`N;
    #`M;
    #10;
    button_in = 00;
    #60;
    coin_in = 20;
    #10;
    coin_in = 0;
    #10;
    button_in = 01;
    #30;
    button_in = 00;
    #40;
    button_in = 01;
    #10;
    #`N;
    #`M;
    coin_in = 10; // <- Anomaly: The user is inserting a coin during a delivery BUT the machine ignores the request.
    #10;
    button_in = 00;
    #10;
    coin_in = 0;
    #`N;
    button_in = 00;
    #200;
    $finish;
  end
endmodule
