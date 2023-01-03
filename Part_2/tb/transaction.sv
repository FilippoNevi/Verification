class transaction;

  rand reg[15:0] coin_in;
  rand reg[1:0] button_in;
  
  constraint coin_in_c { coin_in inside {16'd0, 16'd10, 16'd20, 16'd50, 16'd100, 16'd200};};
  constraint zero_coin_c { button_in inside {2'b01, 2'b11} -> coin_in inside {16'd0}; };
  constraint button_in_c { button_in inside {2'b00, 2'b01, 2'b11}; };
  
  
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    
    $display("\t coin_in = %0d",coin_in);
    $display("\t button_in = %0b",button_in);
    
    $display("-----------------------------------------");
  endfunction
  
  function transaction do_copy();
    transaction trans;
    trans = new();
    
    trans.coin_in = this.coin_in;
    trans.button_in = this.button_in;
    
    return trans;
  endfunction
endclass
