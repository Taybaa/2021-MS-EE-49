class burst;
rand 	logic 	[7:0] 	HADDR;
rand logic 		HWRITE; 
rand logic	[2:0]  	HSIZE;
rand logic	[2:0] 	HBURST;
rand logic 	[3:0] 	HPROT;
rand logic	[1:0]	HTRANS;
rand	logic 	[31:0] 	HWDATA;
logic 		HREADYOUT;
logic 		HRESP;
logic 	[31:0] 	HRDATA;

endclass
