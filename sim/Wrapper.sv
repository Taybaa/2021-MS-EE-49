interface wrap (input bit HCLK,HRESET);
   logic [7:0] HADDR;
   logic [31:0] HRDATA;
   logic [31:0] HWDATA;
   logic [3:0] HPROT;
   logic [2:0] HSIZE;
   logic [2:0] HBURST;
   logic [1:0] HTRANS, HSEL;
   logic HREADY, HREADYOUT, HRESP, HWRITE, HMASTLOCK;
endinterface : wrap

module wrapper (port_a, port_w);
    ahb_intf port_a;
wrap port_w;
    
    assign port_w.HADDR = port_a.HADDR;
    assign port_w.HRDATA = port_a.HRDATA;
    assign port_w.HWDATA = port_a.HWDATA;
    assign port_w.HPROT = port_a.HPROT;
    assign port_w.HSIZE = port_a.HSIZE;
    assign port_w.HBURST = port_a.HBURST;
    assign port_w.HTRANS = port_a.HTRANS;
    assign port_w.HSEL = port_a.HSEL;
    assign port_w.HREADY = port_a.HREADY;
    assign port_w.HREADYOUT = port_a.HREADYOUT;
    assign port_w.HRESP = port_a.HRESP;
    assign port_w.HWRITE = port_a.HWRITE;
    assign port_w.HCLK = port_a.HCLK;
    assign port_w.HRESET = port_a.HRESET;
assign port_w.HMASTLOCK = port_a.HMASTLOCK;

endmodule: wrapper

