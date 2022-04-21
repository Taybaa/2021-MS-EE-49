`include "Transaction.sv"
class generator;
 rand burst bst;
  //declaring mailbox
  mailbox #(burst) gen2driv;
int  repeat_count; 
	
//.....Size......//
localparam WORD		= 010;
localparam H_WORD	= 001;
localparam BYTE		= 000;

event ended;

 function new(mailbox #(burst) gen2driv,event ended);
    this.gen2driv <= gen2driv;  
  this.ended    = ended;
  endfunction


task create_burst(input [2:0] br_type, input [2:0] br_size, int incrwrap_size);
int wrap = 0;
int addr;
int start_addr;
addr = this.bst.HADDR;
if(br_type == 3'b010 || 3'b100 || 3'b110)
begin
	for(int i = 0;i < 40;i++)
		begin
		if( wrap <incrwrap_size) 
		begin
                bst.HADDR 	<= addr + 4;
                bst.HTRANS <= 2'b11;//SEQ
		wrap++;
		end
		
		if(i==0)
                     begin
                       bst.HADDR  <=  addr ;
                       bst.HADDR  <=start_addr ;
			bst.HTRANS <= 2'b10;//NONSEQ	
                         end
else begin 
bst.HADDR  <=  addr ;
bst.HADDR  <=start_addr ;
wrap = 0;
    end

		       bst.HSIZE 	<= br_size;			
	               bst.HBURST 	<= br_type;
                       bst.HPROT  <= 4'b0011;
                       gen2driv.put(bst);
                       repeat_count++;
	end
end


else
begin
	for(int i = 0;i <  incrwrap_size;i++)
	begin
		if(i> 0) 
			bst.HADDR 	<= addr+ 4;
                        bst.HTRANS <= 2'b11;//SEQ
		if(i==0)begin
                        bst.HADDR  <=  addr ;
                       bst.HADDR  <=start_addr ;
			bst.HTRANS 	<= 2'b10;//NONSEQ
end
		else 	
begin
		bst.HTRANS <= 2'b11;
end
		bst.HPROT	<= 4'b0011;
		bst.HSIZE 	<= br_size;			
		bst.HBURST <= br_type;
                gen2driv.put(bst);
                       repeat_count++;
	end
end
	

endtask

task single_burst();
bst=new;
create_burst(3'b001,BYTE,100);
endtask	
	
task wrap4_burst();
bst=new;
create_burst(3'b010,BYTE,4);
endtask	

task incr4_burst();
bst=new;
create_burst(3'b011,BYTE,4);
endtask	



task run;
single_burst();
incr4_burst();
wrap4_burst();
endtask
endclass
