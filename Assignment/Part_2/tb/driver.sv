class driver;

    int no_transactions;
    virtual fsm_intf fsm_vif;
    mailbox gen2driv;

    function new(virtual fsm_intf fsm_vif,mailbox gen2driv);
        this.fsm_vif = fsm_vif;
        this.gen2driv = gen2driv;
    endfunction

    task rst;
        wait(fsm_vif.rst);
        $display("--------- [DRIVER] Reset Started ---------");
        wait(!fsm_vif.rst);
        $display("--------- [DRIVER] Reset Ended ---------");
    endtask

    task drive;
        transaction trans;
        gen2driv.get(trans);
        @(negedge fsm_vif.clk);

        fsm_vif.coin_in=trans.coin_in;
        fsm_vif.button_in=trans.button_in;

        no_transactions++;
    endtask


    task main;
        wait(!fsm_vif.rst);
        forever
            drive();
   endtask

endclass
