interface ahb_intf(input bit HCLK,HRESET);
  
  logic                       	HSEL;
  logic [7:0]    		HADDR;
  logic   [31:0]     			HWDATA;
  logic [31:0]      			HRDATA;
  logic                       	HWRITE;
  logic [2:0]   		HSIZE;
  logic [2:0]     		HBURST;
  logic [3:0]     		HPROT;
  logic  [1:0]     			HTRANS;
  logic                       	HREADYOUT;
  logic                       	HREADY;
  logic                       	HRESP;
  logic           		HMASTLOCK;

 modport DUT(
      	
      	
      	input   	HSEL,
  	input   	HADDR,
 	input   	HWDATA,
  	output 		HRDATA,
  	input           HWRITE,
  	input       	HSIZE,
  	input       	HBURST,
  	input       	HPROT,
  	input       	HTRANS,
  	output 		HREADYOUT,
  	input           HMASTLOCK,
  	output          HRESP

  );
 modport Driver(
      	input   	HRESET,
      	input   	HCLK,
        input 		HRDATA,
      	output   	HSEL,
  	output   	HADDR,
 	output   	HWDATA,
  	output          HWRITE,
  	output       	HSIZE,
  	output       	HBURST,
  	output       	HPROT,
  	output       	HTRANS,
  	input           HREADY,
        output          HMASTLOCK,
	input          HRESP
  );

 modport Monitor(
	input  		HRESET,
      	
      	input   	HSEL,
  	input   	HADDR,
 	input   	HWDATA,
  	input       	HSIZE,
  	input       	HBURST,
  	input       	HPROT,
  	input       	HTRANS,
  	input 		HRDATA,
	input 		HREADYOUT,
        input           HMASTLOCK,
	input          HRESP);
endinterface


