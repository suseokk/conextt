class Packet#(
   ADDR_WIDTH = 32,
   DATA_WIDTH = 32,
   DATA_STRB = (DATA_WIDTH/8));

         bit                    pwrite;
   rand  bit [2:0]              prot;
   randc bit [DATA_STRB-1:0]    pstrb;
         logic [ADDR_WIDTH-1:0] paddr;
   rand  logic [DATA_WIDTH-1:0] pwdata;
         logic [DATA_WIDTH-1:0] prdata;
   //rand  logic [DATA_WIDTH-1:0] prdata;

   constraint c_prot {prot == 1;}
   constraint c_pstrb {pstrb == 4'b1111;}
   //constraint c_prdata {prdata == 0;}
   //constraint c_addr {paddr inside {[0:15]};}
   //constraint c_addr {paddr < 16;}

   function void print(string tag="");
      $display("T=%0t [%s]\tpwrite=%0d paddr=%0h pwdata=%0h prdata=%0h", $time, tag, pwrite, paddr, pwdata, prdata);
   endfunction

   function void copy(Packet tmp);
      this.pwrite =tmp.pwrite;
      this.prot   =tmp.prot;
      this.paddr  =tmp.paddr;
      this.pwdata =tmp.pwdata;
      this.prdata =tmp.prdata;
   endfunction
endclass

class driver;
   virtual tb_if _vif;
   virtual tb_clk_if clk_vif;
   event drv_done;
   mailbox drv_mbx;

   task run();
      _vif.psel    = 0;
      _vif.penable = 0;
      forever begin
         Packet item;

         @(posedge clk_vif.clk);
         drv_mbx.get(item);
         @(negedge clk_vif.clk);
         _vif.psel    = 1;
         _vif.penable = 0;
         _vif.pwrite = item.pwrite;
         _vif.prot   = item.prot;
         _vif.pstrb  = item.pstrb;
         _vif.paddr  = item.paddr;
         _vif.pwdata = item.pwdata;
         item.print("driver");
         @(negedge clk_vif.clk);
         _vif.penable = 1;
         @(negedge clk_vif.clk);
         _vif.psel    = 0;
         _vif.penable = 0;
         ->drv_done;
      end
   endtask
endclass

class generator;
   virtual tb_clk_if clk_vif;
   event drv_done;
   mailbox drv_mbx;

   task run();
      //for (int i=0; i<$size(_vif.paddr); i++)begin
      for (int i=0; i<2; i++) begin
         Packet pkt = new;

         @(negedge clk_vif.clk);
         pkt.randomize();
         //pkt.randomize() with {
         //                        prot == 1;
         //                        pstrb == 4'b1111;};
         if (i < 16) begin
            pkt.pwrite = 1;
            pkt.paddr = i;
         end else begin
            pkt.pwrite = 0;
            pkt.paddr = i-16;
         end
         $display("T=%0t [gernerator]\tpwrite=%0h paddr=%0h pwdata=%0h prdata=%0h %0d/32 ", $time, pkt.pwrite, pkt.paddr, pkt.pwdata, pkt.prdata, i+1);
         drv_mbx.put(pkt);
         @(drv_done);
      end
   endtask
endclass

class monitor;
   virtual tb_if _vif;
   virtual tb_clk_if clk_vif;
   mailbox scb_mbx;

   task run();
      forever begin
         Packet rtl_item = new();

         @(posedge clk_vif.clk);
         if (_vif.psel & _vif.penable) begin
            @(negedge clk_vif.clk);
            rtl_item.pwrite = _vif.pwrite;
            rtl_item.paddr  = _vif.paddr;
            rtl_item.pwdata = _vif.pwdata;
            rtl_item.prdata = _vif.prdata;
            rtl_item.print("Monitor");
            scb_mbx.put(rtl_item);
         end
      end
   endtask
endclass

class scoreboard;
   virtual tb_if _vif;
   virtual tb_clk_if clk_vif;
   mailbox scb_mbx;
   Packet ref_queue[$];

   task run();
      forever begin
         Packet item;

         @(posedge clk_vif.clk);
         scb_mbx.get(item);
         item.print("scoreboard");
         if (_vif.pwrite) begin
            ref_queue[item.paddr] = new;
            ref_queue[item.paddr].copy(item);
            ref_queue[item.paddr].prdata = item.pwdata;
            //ref_queue[item.paddr].print("reference");
         end
         if (!_vif.pwrite) begin
            if (ref_queue[item.paddr].prdata != item.prdata) begin
               $display("T=%0t [scoreboard] ERROR RTL-prdata=%0h REF-prdata=%0h", $time, item.prdata, ref_queue[item.paddr].prdata);
            end else begin
               $display("T=%0t [scoreboard] PASS RTL-prdata=%0h REF-prdata=%0h", $time, item.prdata, ref_queue[item.paddr].prdata);
            end
         end
      end
   endtask
endclass

class env;
   virtual tb_if _vif;
   virtual tb_clk_if clk_vif;
   mailbox drv_mbx;
   event drv_done;
   mailbox scb_mbx;

   driver d0;
   generator g0;
   monitor m0;
   scoreboard s0;

   function new();
      d0 = new;
      g0 = new;
      m0 = new;
      s0 = new;
      drv_mbx = new;
      scb_mbx = new;
   endfunction

   virtual task run();
      d0._vif = _vif;
      d0.clk_vif = clk_vif;
      g0.clk_vif = clk_vif;

      d0.drv_mbx = drv_mbx;
      g0.drv_mbx = drv_mbx;

      d0.drv_done = drv_done;
      g0.drv_done = drv_done;

      m0._vif = _vif;
      s0._vif = _vif;
      m0.clk_vif = clk_vif;
      s0.clk_vif = clk_vif;

      m0.scb_mbx = scb_mbx;
      s0.scb_mbx = scb_mbx;

      fork
         d0.run();
         g0.run();
         m0.run();
         s0.run();
      join_any;
   endtask
endclass


class test;
   env e0;

   function new();
      e0 = new();
   endfunction

   virtual task run();
   e0.run();
   endtask
endclass


interface tb_if#(
   ADDR_WIDTH = 32,
   DATA_WIDTH = 32,
   DATA_STRB = (DATA_WIDTH/8)
   );
   bit nrst;
   bit pwrite;
   bit psel;
   bit penable;
   bit pready;
   bit [2:0] prot;
   bit [DATA_STRB-1:0] pstrb;
   logic [ADDR_WIDTH-1:0] paddr;
   logic [DATA_WIDTH-1:0] pwdata;
   logic [DATA_WIDTH-1:0] prdata;
   logic slverr;
endinterface

interface tb_clk_if();
   bit clk;

   initial begin
      clk <= 0;
   end
   always #10 clk = ~clk;
endinterface

module tb;
   tb_if _if();
   tb_clk_if clk_if();

   APB_SLAVE dut(
      .clk    (clk_if.clk),
      .nrst   (_if.nrst),
      .paddr  (_if.paddr),
      .prot   (_if.prot),
      .pwrite (_if.pwrite),
      .psel   (_if.psel),
      .penable(_if.penable),
      .pwdata (_if.pwdata),
      .pstrb  (_if.pstrb),
      .pready (_if.pready),
      .slverr (_if.slverr),
      .prdata (_if.prdata));

   initial begin
      test t0;
      t0 = new;

      t0.e0._vif = _if;
      t0.e0.clk_vif = clk_if;

      _if.nrst <= 0;
      @(posedge clk_if.clk);
      _if.nrst <= 1;
      t0.run();

      #100 $finish;
   end
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
   end
endmodule

