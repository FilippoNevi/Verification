`timescale 1ns/1ns
`define N 10 // delay of beverages delivering
`define M 20 // delay of change delivering

module test;
  logic clk, rst;
  reg[15:0] coin_in;
  reg[1:0] button_in;
  reg[1:0] beverage_out;
  reg[15:0] change_out;
  
  // Instantiate device under test
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
    // button_in: almeno 30
    // coin_in: almeno 10
    clk = 0;
    rst = 1;
    button_in = 00; // non decisione
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
    button_in = 10;   // ANOMALY =====> Invalid button
    #10;
    button_in = 00;
    #30;
    button_in = 11; // Expected c = 120 and beverage_out = 11
    #10;
    button_in = 00;
    #40;
    button_in = 11; // Expected c = 70 and beverage_out = 11
    #10;
    button_in = 00;
    #50;
    button_in = 01; // Expected c = 40, beverage_out = 01
    #10;
    button_in = 00;
    #40;
    button_in = 01; // Expected c = 10, beverage_out = 01, change_out = 10
    #10; // 10
    button_in = 00;
   
   	/* Inizio anomalia
   	#100;
    rst = 1;
    #10;
    button_in = 00; // non decisione
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
    button_in = 10; // Expected c = 170 <- ANOMALIA HERE
    #`N
    #10;
    button_in = 00;
    // #`N; // delay beverage
    #30;
    button_in = 11; // Expected c = 120
    #`N
    #10;
    button_in = 00;
    // #`N; // delay beverage
    #40;
    button_in = 11; // Expected c = 70
    #`N
    #10;
    button_in = 00;
    // #`N; // delay beverage
    #50;
    button_in = 01; // Expected c = 40
    #`N
    #10;
    button_in = 00;
    #40;
    button_in = 01; // Expected c = 10
    #`N; // 10
    #`M; // 20
    #10; // 10
    button_in = 00;
   	// Fine anomalia */
   
    #60;
    coin_in = 20; // c = 80
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
    coin_in = 10; // <- Anomalia: The user is adding coin during the delivering BUT the machine ignores the request.
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

