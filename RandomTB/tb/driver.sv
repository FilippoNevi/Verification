//gets the packet from generator and drive the transaction paket items into interface (interface is connected to DUT, so the items driven into interface signal will get driven in to DUT) 
class driver;

    //used to count the number of transactions
    int no_transactions;

    //creating virtual interface handle
    virtual fsm_intf fsm_vif;

    //creating mailbox handle
    mailbox gen2driv;

    //constructor
    function new(virtual fsm_intf fsm_vif,mailbox gen2driv);
        //getting the interface
        this.fsm_vif = fsm_vif;
        //getting the mailbox handles from  environment 
        this.gen2driv = gen2driv;
    endfunction

    //Reset task, Reset the Interface signals to default/initial values
    task reset;
        wait(fsm_vif.reset);
        $display("--------- [DRIVER] Reset Started ---------");
        wait(!fsm_vif.reset);
        $display("--------- [DRIVER] Reset Ended ---------");
    endtask

    //drives the transaction items to interface signals
    task drive;
        transaction trans;
        //get the transacation
        gen2driv.get(trans);
        //wait for the next negedge to inject the inputs into the DUT
        @(negedge fsm_vif.clk);

        //inject the inputs
        fsm_vif.a=trans.a;

        no_transactions++;
    endtask


    task main;
        wait(!fsm_vif.reset);
        forever
            drive();
   endtask

endclass
