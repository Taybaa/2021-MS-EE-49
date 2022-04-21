`include "Enviornment.sv"
program test(ahb_intf intf);
   environment env;
  localparam bursts = 1000;		// In order to write or read random many bursts
  logic [2:0] br_type;
  logic [2:0] br_size;
  int incrwrap_size; 
 
   
  initial begin

   env = new(intf); 
test_9();
	$stop;
  end


task randomize();
forever begin
	br_type = $random;
        br_size = $random;
        incrwrap_size = $random;

	env.gen.create_burst(br_type,br_size,incrwrap_size);
	wait(env.gen.repeat_count == bursts);
	$stop;
end
endtask

task test_9();
gen.addr = 'h3C ;
env.gen.wrap4_burst();

env.run();

endtask

endprogram

