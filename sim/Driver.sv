`include "Generator.sv"
`define DRIV_IF mem_vif.DRIVER.driver_cb

class driver;
	
  //creating virtual interface handle
  virtual mem_intf mem_vif;
	
  mailbox gen2driv;
   
  function new(virtual mem_intf mem_vif,mailbox gen2driv);
    //getting the interface
    this.mem_vif = mem_vif;
    //getting the mailbox handle from  environment
    this.gen2driv = gen2driv;
  endfunction
   

  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(mem_vif.HRESET);
    $display("--------- [DRIVER] Reset Started ---------");
	`DRIV_IF.HADDR	<= '0;
	`DRIV_IF.HWDATA	<= '0;
	`DRIV_IF.HWRITE	<= '0;
	`DRIV_IF.HSIZE	<= '0;
	`DRIV_IF.HBURST <= '0;
	`DRIV_IF.HPROT	<= '0;
	`DRIV_IF.HTRANS	<= '0;
	`DRIV_IF.HREADY	<= '0;       
    wait(!mem_vif.HRESET);
    $display("--------- [DRIVER] Reset Ended---------");
  endtask

  task write;
      burst bst;
	  gen2driv.get(bst);
      if(`DRIV_IF.HREADYOUT && !`DRIV_IF.HRESP)
	begin
	`DRIV_IF.HSEL 	<= 1;
	`DRIV_IF.HREADY	<= 1;
	`DRIV_IF.HWRITE	<= 1;
	`DRIV_IF.HADDR 	<= bst.HADDR;
	`DRIV_IF.HSIZE	<= bst.HSIZE;
	`DRIV_IF.HBURST	<= bst.HBURST;
	`DRIV_IF.HPROT	<= bst.HPROT;
	`DRIV_IF.HTRANS	<= bst.HTRANS;
	@(posedge mem_vif.DRIVER.clk)
	`DRIV_IF.HWDATA	<= bst.HWDATA;
	end
endtask

task read;
      burst bst;
	gen2driv.get(bst);
      if(`DRIV_IF.HREADYOUT && !`DRIV_IF.HRESP)
	begin
	`DRIV_IF.HSEL 	<= 1;
	`DRIV_IF.HREADY	<= 1;
	`DRIV_IF.HWRITE	<= 0;
	`DRIV_IF.HADDR 	<= bst.HADDR;
	`DRIV_IF.HSIZE	<= bst.HSIZE;
	`DRIV_IF.HBURST	<= bst.HBURST;
	`DRIV_IF.HPROT	<= bst.HPROT;
	`DRIV_IF.HTRANS	<= bst.HTRANS;
	end    
  endtask 
task run();
	reset();
	write();
	read(); 
endtask       
endclass
