class transaction;
  //declaring the transaction items
  //rand logic a;
  
  rand reg[15:0] coin_in;
  rand reg[1:0] button_in;
  
  //constraint in_c { in inside {[10:16]}; }; 
  //constraint a_c { a inside {[0:1]}; };
  
  constraint coin_in_c { coin_in inside {10, 20, 50, 100, 200}; };
  constraint button_in_c { button_in inside {00, 01, 11}; };
  
  
  //post-randomize function, displaying randomized values of items 
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    //$display("\t start = %0h",start);
    //$display("\t in = %0h",in);
    //$display("\t dec = %0h",dec);
    //$display("\t a = %0h",a);
    
    $display("\t coin_in = %0h",coin_in);
    $display("\t button_in = %0h",button_in);
    
    $display("-----------------------------------------");
  endfunction
  
  //deep copy method
  function transaction do_copy();
    transaction trans;
    trans = new();
    //trans.start  = this.start;
    //trans.in  = this.in;
    //trans.dec  = this.dec;
    //trans.a  = this.a;
    
    trans.coin_in = this.coin_in;
    trans.button_in = this.button_in;
    
    return trans;
  endfunction
endclass
