interface AHB_if(input HCLK);
  logic				HRESET;
  logic                       	HSEL;
  logic      			HADDR;
  logic       			HWDATA;
  logic       			HRDATA;
  logic                       	HWRITE;
  logic      			HSIZE;
  logic       			HBURST;
  logic       			HPROT;
  logic       			HTRANS;
  logic                       	HREADYOUT;
  logic                       	HREADY;
  logic                       	HRESP;

 modport DUT(
      	input  		HRESET,
      	input  		HCLK,
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
  	input           HREADY,
  	output          HRESP
  );
 modport Driver(
      	output  	HRESET,
      	output  	HCLK,
      	output   	HSEL,
  	output   	HADDR,
 	output   	HWDATA,
  	output          HWRITE,
  	output       	HSIZE,
  	output       	HBURST,
  	output       	HPROT,
  	output       	HTRANS,
  	output          HREADY,
	input 		HREADYOUT,
	input          HRESP
  );

 modport Monitor(
	input  		HRESET,
      	input  		HCLK,
      	input   	HSEL,
  	input   	HADDR,
 	input   	HWDATA,
  	input           HWRITE,
  	input       	HSIZE,
  	input       	HBURST,
  	input       	HPROT,
  	input       	HTRANS,
  	input           HREADY,	
	input 		HRDATA,
	input 		HREADYOUT,
	input          HRESP);
endinterface

