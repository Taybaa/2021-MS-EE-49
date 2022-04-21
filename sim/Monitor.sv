`include "Transaction.sv";
class monitor;
   
  //creating virtual interface handle
  virtual ahb_intf.Monitor monitor_if;
   burst bst;
  //creating mailbox handle
  mailbox #(burst) mon2scb;
event complete;
//constructor
  function new(virtual ahb_intf.Monitor monitor_if,mailbox #(burst) mon2scb);
//getting the interface
this.monitor_if = monitor_if;
//getting the mailbox handle from  environment
this.mon2scb = mon2scb;
endfunction
   
  //Samples the interface signal and send the sample packet to scoreboard
  task observe();
    bst = new();
begin 
     
      if(!monitor_if.HRESP || monitor_if.HREADYOUT );
begin
bst = new();
 
       monitor_if.HSEL<=1;
       monitor_if.HREADY<=1;
       bst.HADDR  = monitor_if.HADDR;
       bst.HSIZE  = monitor_if.HSIZE;
       bst.HBURST = monitor_if.BURST;
       bst.HPROT  = monitor_if.HPROT; 
       bst.HTRANS  = monitor_if.HTRANS;
       bst.HWDATA    = monitor_inf.HWDATA;
        if(monitor_if.HWRITE) begin
          @(posedge monitor_if.HCLK);
        
          bst.HWDATA = monitor_if.HWDATA;
        end    
 else if (!monitor_if.HWRITE);
 begin
          
          @(posedge monitor_if.HCLK);
          bst.HRDATA = monitor_if.HRDATA;
       
        end     
        mon2scb.put(bst);
 ->complete;
    end
end
  endtask

task run();
forever begin
observe();
   end
 
  endtask 
endclass