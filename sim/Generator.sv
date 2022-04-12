`include "Transaction1.sv"
class generator;
   
  //declaring transaction class
 rand transaction trans;
   
  //declaring mailbox
  mailbox gen2driv;

logic 	[31:0] 	haddr;
logic 		hwrite;
logic [31:0]hwdata;
int b; //beats
logic [2:0] hsize;

 function new(mailbox gen2driv);
    this.gen2driv <= gen2driv;    
  endfunction

localparam WORD		= 010;

task SB();	//Single Burst	
		trans = new; 
		this.trans.HADDR=haddr;
		this.trans.HWDATA=hwdata;
		this.trans.HBURST = 3'b000; 
       	 	this.trans.HWRITE = hwrite; 
     		this.trans.HTRANS = 3'b010; // Non-Sequential 
		gen2driv.put(trans);
		$display("Address:0x%0h towards driver\n",trans.HADDR);
	 		b=b-1;
		repeat(b)	
      			begin
			trans=new;
       			this.trans.HWRITE = hwrite; 
       			this.trans.HBURST = 3'b000; 
      			this.trans.HTRANS = 3'b011; // SEQ for the remaining beats
      			this.trans.HSIZE = WORD; // (32-bits)
      			case(trans.HSIZE)
				3'b000 : hsize = 1;
              			3'b001 : hsize = 2;
          			3'b010 : hsize = 4;
        		endcase 
       			gen2driv.put(trans);	
			haddr=haddr+hsize;
			this.trans.HADDR = haddr;
			$display("Address:0x%0h towards mailbox",trans.HADDR);
			end
	
		$display("Single burst sent to driver\n");
		endtask  

 task INCR4();			
		trans = new; 
		this.trans.HADDR=haddr;
		this.trans.HWDATA=hwdata;
		this.trans.HBURST = 3'b011; //4 Beat Incrementing Burst
       	 	this.trans.HWRITE = hwrite; 
     		this.trans.HTRANS = 3'b010; // Non-Sequential 
		gen2driv.put(trans);
		$display("Address:0x%0h towards driver\n",trans.HADDR);
	 		
		repeat(3)	
      			begin
			trans=new;
       			this.trans.HWRITE = hwrite; 
       			this.trans.HBURST = 3'b011; //4 Beat Incrementing Burst
      			this.trans.HTRANS = 3'b011; // SEQ for the remaining beats
      			this.trans.HSIZE = WORD; // (32-bits)
      			case(trans.HSIZE)
				3'b000 : hsize = 1;
              			3'b001 : hsize = 2;
          			3'b010 : hsize = 4;
        		endcase 
       			gen2driv.put(trans);	
			haddr=haddr+hsize;
			this.trans.HADDR = haddr;
			$display("Address:0x%0h towards mailbox",trans.HADDR);
			end
	
		$display("INCR4 burst sent to driver\n");
		endtask  

task INCR8();	
                trans = new; 
		this.trans.HADDR=haddr;
		this.trans.HWDATA=hwdata;
		this.trans.HBURST = 3'b101; //8 Beat Incrementing Burst
       	 	this.trans.HWRITE = hwrite; 
     		this.trans.HTRANS = 3'b010; // Non-Sequential 
		gen2driv.put(trans);
		$display("Address:0x%0h towards driver\n",trans.HADDR);
	 		
		repeat(7)	
      			begin
			trans=new;
       			this.trans.HWRITE = hwrite; 
       			this.trans.HBURST = 3'b101; //8 Beat Incrementing Burst
      			this.trans.HTRANS = 3'b011; // SEQ for the remaining beats
      			this.trans.HSIZE = WORD; // (32-bits)
      			case(trans.HSIZE)
				3'b000 : hsize = 1;
              			3'b001 : hsize = 2;
          			3'b010 : hsize = 4;
        		endcase 
       			gen2driv.put(trans);	
			haddr=haddr+hsize;
			this.trans.HADDR = haddr;
			$display("Address:0x%0h towards mailbox",trans.HADDR);
			end
	
		$display("INCR8 burst sent to driver\n");
		endtask  
  
endclass
