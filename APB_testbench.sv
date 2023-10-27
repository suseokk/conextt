class Packet#(
   //ADDR_WIDTH = 32,
   DATA_WIDTH = 32,
   DATA_STRB = (DATA_WIDTH/8));

   randc bit [2:0] prot;
   randc bit [DATA_STRB-1:0] pstrb;
   //randc logic [ADDR_WIDTH-1:0] paddr;
   randc logic [3:0] paddr;
   randc logic [DATA_WIDTH-1:0] pwdata;
   randc logic [DATA_WIDTH-1:0] prdata;

   function void print(string tag="");
      $display("T=%0t [%s] paddr=%0h pwdata=%0h prdata=%0h", $time, tag, paddr, pwdata, prdata);
   endfunction
endclass

class driver;
   virtual tb_if _vif;
   virtual tb_clk_if clk_vif;
   event drv_done;
   mailbox drv_mbx;

   task run();
      $display("driver is starting");
      _vif.psel    = 0;
      _vif.penable = 0;
      forever begin
         Packet item;
         @(posedge clk_vif.clk);
         drv_mbx.get(item);
         item.print("driver");
         @(negedge clk_vif.clk);
         _vif.psel    = 1;
         _vif.penable = 0;
         @(negedge clk_vif.clk);
         _vif.penable = 1;
         @(posedge clk_vif.clk);
         _vif.prot   = item.prot;
         _vif.pstrb  = item.pstrb;
         _vif.paddr  = item.paddr;
         _vif.pwdata = item.pwdata;
         _vif.prdata = item.prdata;
         ->drv_done;
         @(negedge clk_vif.clk);
         _vif.psel    = 0;
         _vif.penable = 0;
      end
   endtask
endclass

class generator;
   virtual tb_if _vif;
   virtual tb_clk_if clk_vif;
   event drv_done;
   mailbox drv_mbx;

   task run();
      //for (int i=0; i<$size(_vif.paddr); i++)begin
      for (int i=0; i<1; i++)begin
         Packet item = new;
         item.randomize() with {
                                 prot == 1;
                                 pstrb == 4'b1111;};
         $display("T=%0t %0d/%0d [gernerated] paddr=%0h pwdata=%0h prdata=%0h",$time, i+1,$size(_vif.paddr), item.paddr, item.pwdata, item.prdata);
         drv_mbx.put(item);
         @(drv_done);
         @(negedge clk_vif.clk);
      end
   endtask
endclass

class monitor;
   virtual tb_if _vif;
   virtual tb_clk_if clk_vif;
   mailbox scb_mbx;

   task run();
      $display("monitor is starting");
      @(posedge clk_vif.clk);
      forever begin
         Packet rtl_item = new();
         @(posedge clk_vif.clk);
         if (_vif.psel & _vif.penable) begin
            //rtl_item.prot   = _vif.prot;
            //rtl_item.pstrb  = _vif.pstrb;
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
   Packet ref_item[32];

   task run();
      forever begin
         Packet rtl_item;
         scb_mbx.get(rtl_item);
         rtl_item.print("scoreboard");
         /**if (rtl_item.pwrite & rtl_item.psel & rtl_item.penable & rtl_item.pready) begin
            ref_item[rtl_item.paddr] = rtl_item;
         end
         if (ref_item[rtl_item.paddr].prdata == rtl_item.prdata) begin
            $display("T=%0t PASS ref_prdata=%0h rtl_prdata=%0h",$time, ref_item[rtl_item.paddr], rtl_item.prdata);
         end else begin
            $display("T=%0t FAIL ref_prdata=%0h rtl_prdata=%0h",$time, ref_item[rtl_item.paddr], rtl_item.prdata);
         end**/
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
      g0._vif = _vif;
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
      /**
      _if.nrst <= 0;
      #20 _if.nrst <= 1;
      #20 _if.psel <= 1;
      #20 _if.penable <= 1;
      _if.pwrite <= 1;
      //paddr <= 2;
      _if.prot <= 0;
      _if.pstrb <= 4'b1111;
      for(int i=0; i<16; i++)begin
         _if.pwdata = $urandom();
         _if.paddr = i;
         #20;
      end
      run();
      #20 _if.pwrite <= 0;
      for(int i=0; i<16; i++)begin
         _if.paddr = i;
         #20;
      end**/
      test t0;
      t0 = new;

      t0.e0._vif = _if;
      t0.e0.clk_vif = clk_if;

      _if.nrst <= 0;
      #10 _if.nrst <= 1;
      t0.run();

      #100 $finish;
   end
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
   end
endmodule

