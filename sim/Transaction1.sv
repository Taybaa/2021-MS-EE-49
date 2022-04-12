class transaction;
rand 	logic 	[31:0] 	HADDR;
rand logic 		HWRITE; 
rand logic	[2:0]  	HSIZE;
rand logic	[2:0] 	HBURST;
rand logic 	[3:0] 	HPROT;
rand logic	[1:0]	HTRANS;
rand	logic 	[31:0] 	HWDATA;
logic 		HREADYOUT;
logic 		HRESP;
logic 	[31:0] 	HRDATA;


function void print(string tag="");
$display ("T=%0t [%s] HADDR=0x%0h HWDATA=0x%0h HRDATA=0x%0h HWRITE=%d",$time,tag,HADDR,HWDATA,HRDATA,HWRITE);
endfunction
endclass