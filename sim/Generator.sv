`include "Transaction1.sv"
//.....Generator Class.....//

class generator;
 rand burst bst;
  //declaring mailbox
  mailbox gen2driv;
	
//.....Size......//
localparam WORD		= 010;
localparam H_WORD	= 001;
localparam BYTE		= 000;
	
 function new(mailbox gen2driv);
    this.gen2driv <= gen2driv;    
  endfunction
	
task make_burst(input [2:0] burst_type, input [2:0] burst_size, int wrap_or_incr_size);
int wrap = 0;
int addr;
addr = HADDR;
if(burst_type == 3'b010 || 3'b100 || 3'b110)
begin
	for(int i = 0;i < 40;i++)
		begin
		if( wrap <wrap_or_incr_size) 
		begin
		HADDR 	<= HADDR + 1;
		wrap++;
		end
		else 
		begin
		HADDR 	<= addr;
		wrap 	 = 0;
		end
		HSIZE 	<= burst_size;			
		HBURST 	<= burst_type;
		if(i==0)
			HTRANS <= 2'b10;
		else 	HTRANS <= 2'b11;
		HPROT 	<= 4'b0011;
	end
end
else
begin
	for(int i = 0;i <  wrap_or_incr_size;i++)
	begin
		if(i> 0) 
			HADDR 	<= HADDR + 1;
		if(i==0)
			HTRANS 	<= 2'b10;
		else 	
			HTRANS 	<= 2'b11;
		HPROT	<= 4'b0011;
		HSIZE 	<= burst_size;			
		HBURST 	<= burst_type;
	end
end
	

endtask 
task single_burst();
bst=new;
bst.randomize();
bst.create(3'b001,BYTE,100);
gen2drive.put(bst);
endtask	
	
task wrap4_burst();
bst=new;
bst.randomize();
bst.create(3'b010,BYTE,4);
gen2drive.put(bst);
endtask	

task incr4_burst();
bst=new;
bst.randomize();
bst.create(3'b011,BYTE,4);
gen2drive.put(bst);
endtask	
	
task run;
single_burst();
incr4_burst();
wrap4_burst();
endtask
endclass
