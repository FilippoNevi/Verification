interface fsm_intf(input clk, rst);
  
  //declaring the signals
  //logic a;
  //logic out1;
  //logic out2;
  //logic out3;
  
  reg[15:0] coin_in;
  reg[1:0] button_in;
  
  reg[15:0] change_out;
  reg[1:0] beverage_out;
  
  modport dut (input clk, rst, coin_in, button_in, output change_out, beverage_out);

endinterface
