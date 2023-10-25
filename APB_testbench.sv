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
      #20 penable <= 1;
      pwrite <= 1;
      //paddr <= 2;
      prot <= 0;
      pstrb <= 4'b1111;
      for(int i=0; i<16; i++)begin
         pwdata = $urandom();
         paddr = i;
         #20;
      end
      #20 pwrite <= 0;
      for(int i=0; i<16; i++)begin
         paddr = i;
         #20;
      end
      #100 $finish;
   end
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
   end
   always #10 clk = ~clk;
endmodule

