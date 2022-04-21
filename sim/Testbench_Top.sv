`include "Interface.sv"
`include "Wrapper.sv"
`include "Test.sv"
 
module tbench_top;
   
  //clock and reset signal declaration
  bit clk;
  bit reset;
   
  
   
  //reset Generation
  initial begin
  //clock generation
  forever #10 clk = ~clk;
    #1 reset = 0;
    #5 reset =1;
  end
   
  //creatinng instance of interface, inorder to connect DUT and testcase
  ahb_intf intf(clk,reset);
   
  
  test t1(intf);
   wrapper wif(clk,reset);
  
endmodule
