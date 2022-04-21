`include "Transaction.sv"
class driver;


event ended;
	
//creating virtual interface handle
virtual ahb_intf.Driver driver_if;
	
mailbox gen2driv;
   
function new(virtual ahb_intf.Driver driver_if,mailbox gen2driv);
//getting the interface
this.driver_if = driver_if;
//getting the mailbox handle from  environment
this.gen2driv = gen2driv;
endfunction
   

//Reset task, Reset the Interface signals to default/initial values
task reset;
wait(driver_if.HRESET);
$display("--------- [DRIVER] Reset Started ---------");
	driver_if.HADDR	<= '0;
	driver_if.HWDATA<= '0;
	driver_if.HWRITE<= '0;
	driver_if.HSIZE	<= '0;
	driver_if.HBURST<= '0;
	driver_if.HPROT<= '0;
	driver_if.HTRANS<= '0;
	driver_if.HREADY<= '0; 
        driver_if.HRESP  <= 0;      
    wait(!driver_if.HRESET);
    $display("--------- [DRIVER] Reset Ended---------");
  endtask

  task write;
      burst bst;
	  gen2driv.get(bst);

      if(driver_if.HREADYOUT && !driver_if.HRESP)
	begin
	driver_if.HSEL 	<= 1;
	driver_if.HREADY<= 1;
	driver_if.HWRITE<= 1;
	driver_if.HADDR <= bst.HADDR;
	driver_if.HSIZE	<= bst.HSIZE;
	driver_if.HBURST<= bst.HBURST;
	driver_if.HPROT	<= bst.HPROT;
	driver_if.HTRANS<= bst.HTRANS;
	@(posedge driver_if.HCLK)
	driver_if.HWDATA<= bst.HWDATA;
->ended;
	end
endtask

task read;
      burst bst;
	gen2driv.get(bst);
      if(driver_if.HREADYOUT && !driver_if.HRESP)
	begin
	driver_if.HSEL 	<= 1;
	driver_if.HREADY<= 1;
	driver_if.HWRITE<= 0;
	driver_if.HADDR <= bst.HADDR;
	driver_if.HSIZE	<= bst.HSIZE;
	driver_if.HBURST<= bst.HBURST;
	driver_if.HPROT	<= bst.HPROT;
	driver_if.HTRANS<= bst.HTRANS;
	end    

      
  endtask 
 
task run();
forever begin
	write();
	read(); 
end
endtask       
endclass
