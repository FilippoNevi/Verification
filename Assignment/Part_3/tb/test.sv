`include "environment.sv"
program test(fsm_intf intf);

    class my_trans extends transaction;
        function void pre_randomize();
        	// a.rand_mode(1);
            coin_in.rand_mode(1);
            button_in.rand_mode(1);
        endfunction
    endclass

    environment env;
    my_trans my_tr;

    initial begin
        env = new(intf);
        my_tr = new();
        env.gen.repeat_count = 1000;
        env.gen.trans = my_tr;
        env.run();
    end
endprogram
