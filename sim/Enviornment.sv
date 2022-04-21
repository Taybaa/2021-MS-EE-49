
`include "Generator.sv"
`include "Driver.sv"
`include "Monitor.sv"
`include "Scoreboard.sv"


class environment;
   
  //generator and driver instance
  generator gen;
  driver    driv;
  monitor    mon;
  scoreboard scb;
   
  //mailbox handle's
  mailbox #(burst) gen2driv;
  mailbox #(burst) mon2scb;

event gen_ended;

  //virtual interface
  virtual ahb_intf vif;
   
  //constructor
  function new(virtual ahb_intf vif);
    //get the interface from test
    this.vif = vif;
     
    //creating the mailbox (Same handle will be shared across generator and driver)
    gen2driv = new();
     mon2scb  = new();

    //creating generator and driver
    gen = new(gen2driv,gen_ended);
    driv = new(vif,gen2driv);
    mon  = new(vif,mon2scb);
    scb  = new(mon2scb);
  endfunction

task pre_test();
    driv.reset();
  endtask
   
  task test();
    fork
    gen.run();
    driv.run();
    mon.run();
    scb.run();   
    join_any
  endtask
   
  task post_test();
    
    wait(gen.repeat_count == 1000);
wait(scb.count_burst == 1000);
  endtask 

  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask 
endclass
