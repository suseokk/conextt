module tb
   #(
   ADDR_WIDTH = 32,
   DATA_WIDTH = 32,
   DATA_STRB = (DATA_WIDTH/8)
   );

   bit clk;
   bit nrst;
   bit [2:0] prot;
   bit pwrite;
   bit psel;
   bit penable;
   logic [ADDR_WIDTH-1:0] paddr;
   logic [DATA_WIDTH-1:0] pwdata;
   bit [DATA_STRB-1:0] pstrb;
   bit pready;
   reg slverr;
   reg [DATA_WIDTH-1:0] prdata;

   APB_SLAVE dut(
      .clk(clk),
      .nrst(nrst),
      .paddr(paddr),
      .prot(prot),
      .pwrite(pwrite),
      .psel(psel),
      .penable(penable),
      .pwdata(pwdata),
      .pstrb(pstrb),
      .pready(pready),
      .slverr(slverr),
      .prdata(prdata)
   );


   initial begin
      clk <= 0;
      nrst <= 0;
      #20 nrst <= 1;
      #20 psel <= 1;
      penable <= 1;
      pwrite <= 1;
      paddr <= 2;
      prot <= 3'b1;
      pwdata <= 32'h1004;
      #20 pwrite <= 0;
      #20 $display("pwdata = %0h prdata = %0h",pwdata, prdata);
      #100 $finish;
   end
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
   end
   always #10 clk = ~clk;
endmodule

