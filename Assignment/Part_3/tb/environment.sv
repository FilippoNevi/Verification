`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

class environment;
  
  generator gen;
  driver    driv;
  mailbox gen2driv;
  
  event gen_ended;
  virtual fsm_intf fsm_vif;
  
  function new(virtual fsm_intf fsm_vif);
    this.fsm_vif = fsm_vif;
    gen2driv = new();
    gen  = new(gen2driv,gen_ended);
    driv = new(fsm_vif,gen2driv);
  endfunction
  
  task pre_test();
    driv.rst();
  endtask
  
  task test();
    fork 
        gen.main();
        driv.main();
    join_none
  endtask
  
  task post_test();
    wait(gen_ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
  endtask  
  
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask
  
endclass

