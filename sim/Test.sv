`include "Enviornment.sv"
program test(ahb_intf intf);
   
 
   
  initial begin
 environment env;
    
 env.run();
   
  end
endprogram

