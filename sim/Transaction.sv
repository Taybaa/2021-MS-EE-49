class burst;
rand 	logic 	[7:0] 	HADDR;
logic 		HWRITE; 
logic	[2:0]  	HSIZE;
logic	[2:0] 	HBURST;
logic 	[3:0] 	HPROT;
logic	[1:0]	HTRANS;
rand	logic 	[31:0] 	HWDATA;
logic 		HREADYOUT;
logic 		HRESP;
logic 	[31:0] 	HRDATA;
bit HRESET;
bit HSEL;

 
endclass
