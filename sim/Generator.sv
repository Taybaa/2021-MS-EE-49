`include "Transaction.sv"
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

task create_burst(input [2:0] br_type, input [2:0] br_size, int incrwrap_size);
int wrap = 0;
int addr;
addr = this.bst.HADDR;
if(br_type == 3'b010 || 3'b100 || 3'b110)
begin
	for(int i = 0;i < 40;i++)
		begin
		if( wrap <incrwrap_size) 
		begin
		this.bst.HADDR 	<= this.bst.HADDR + 1;
		wrap++;
		end
		else 
		begin
		this.bst.HADDR 	<= addr;
		wrap 	 = 0;
		end
		this.bst.HSIZE 	<= br_size;			
		this.bst.HBURST 	<= br_type;
		if(i==0)
			this.bst.HTRANS <= 2'b10;
		else 	this.bst.HTRANS <= 2'b11;
		this.bst.HPROT 	<= 4'b0011;
	end
end
else
begin
	for(int i = 0;i <  incrwrap_size;i++)
	begin
		if(i> 0) 
			this.bst.HADDR 	<= this.bst.HADDR + 1;
		if(i==0)
			this.bst.HTRANS 	<= 2'b10;
		else 	
			this.bst.HTRANS 	<= 2'b11;
		this.bst.HPROT	<= 4'b0011;
		this.bst.HSIZE 	<= br_size;			
		this.bst.HBURST 	<= br_type;
	end
end
	

endtask

task single_burst();
bst=new;
randomize();
create_burst(3'b001,BYTE,100);
gen2drive.put(bst);
endtask	
	
task wrap4_burst();
bst=new;
randomize();
create_burst(3'b010,BYTE,4);
gen2drive.put(bst);
endtask	

task incr4_burst();
bst=new;
randomize();
create_burst(3'b011,BYTE,4);
gen2drive.put(bst);
endtask	
	
task run;
single_burst();
incr4_burst();
wrap4_burst();
endtask
endclass
