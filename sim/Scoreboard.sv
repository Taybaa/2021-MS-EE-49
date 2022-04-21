`include "Transaction.sv";
class scoreboard;
    
  //creating mailbox handle
  mailbox #(burst) mon2scb;
   burst bst;
  int count_burst;
int count_error;
   
  //array to use as local memory
  logic [31:0] mem[int];


   
  //constructor
  function new(mailbox #(burst)mon2scb);
    //getting the mailbox handles from  environment
    this.mon2scb = mon2scb;
  endfunction
   
  //stores wdata and compare rdata with stored data
  task report;
   
      
      mon2scb.get(bst);
if(bst.HWRITE)
begin
        mem[bst.HADDR] = bst.HWDATA;

end
      else if(mem[bst.HADDR] == bst.HWDATA)begin
          $display("[SCB-PASS]");
count_burst++;
      end
 else 
begin
      $display("[SCB-FAIL]");
count_error++;
        end

  endtask

task run();
forever begin
report();
end
endtask
endclass
