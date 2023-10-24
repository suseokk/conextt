class Packet;
   //rand  bit      rstn;
   rand bit [3:0] a;
   rand bit [3:0] b;
        bit [7:0] y;

   function void print(string tag="");
      //$display("T=%0t  %s  a=0x%0h  b=0x%0h sum=0x%0h carry=0x%0h",
      $display("T=%0t [%s] a=%0d b=%0d y=%0d",
               $time, tag, a, b, y);
   endfunction

   function void copy(Packet tmp);
      //this.rstn   = tmp.rstn;
      this.a = tmp.a;
      this.b = tmp.b;
      this.y = tmp.y;
   endfunction
endclass

class driver;
   virtual mul_if _vif;
   virtual clk_if clk_vif;
   event drv_done;
   mailbox drv_mbx;

   task run();
      //$display("T=%0t [Driver] starting ...", $time);

      forever begin
         Packet item;
         //$display("T=%0t [Driver] waiting for item ...", $time);
         drv_mbx.get(item);
         @ (posedge clk_vif.tb_clk);
         item.print("DRIVER");
         //_vif.rstn <= item.rstn;
         _vif.a <= item.a;
         _vif.b <= item.b;
         ->drv_done;
      end
   endtask
endclass

class monitor;
   virtual mul_if _vif;
   virtual clk_if clk_vif;
   mailbox scb_mbx;

   task run();
      //$display("T=%0t [monitor] starting ...", $time);
      forever begin
         Packet m_pkt = new();
         @ (posedge clk_vif.tb_clk);
         #1;
         //m_pkt.rstn  = _vif.rstn;
         m_pkt.a = _vif.a;
         m_pkt.b = _vif.b;
         m_pkt.y = _vif.y;
         //m_pkt.carry = _vif.carry;
         m_pkt.print("MONITOR");
         scb_mbx.put(m_pkt);
      end
   endtask
endclass

class scoreboard;
   mailbox scb_mbx;
   task run();
      forever begin
         Packet item, ref_item;
         scb_mbx.get(item);
         item.print("SCOREBOARD");
         ref_item = new();
         ref_item.copy(item);
         /**if (!ref_item.rstn) begin
            {ref_item.carry, ref_item.sum} = ref_item.a + ref_item.b;
         end else begin
            {ref_item.carry, ref_item.sum} = 0;
         end**/
         ref_item.y = ref_item.a * ref_item.b;
         if (ref_item.y != item.y) begin
            $display("T=%0t RTL : %0d Ref : %0d Scoreboard ERROR",
                     $time, item.y, ref_item.y);
         end else begin
            $display("T=%0t RTL : %0d Ref : %0d Scoreboard PASS",
                     $time, item.y, ref_item.y);
         end
      end
   endtask
endclass

class generator;
   int loop = 10;
   event drv_done;
   mailbox drv_mbx;
   virtual clk_if clk_vif;

   task run();
      for (int i=0; i<loop; i++) begin
         Packet item = new;
         item.randomize();
         $display("T=%0t [Generator] creating item %0d/%0d",
                  $time, i+1, loop);
         drv_mbx.put(item);
         item.print("GENERATOR");
         //$display("T=%0t [Generator] waiting for Driver done", $time);
         @(drv_done);
         //$display("T=%0t [Generator] Finished generating", $time);
         @(negedge clk_vif.tb_clk);
      end
   endtask
endclass

class env;
   generator   g0;
   driver      d0;
   monitor     m0;
   scoreboard  s0;
   mailbox     drv_mbx;
   mailbox     scb_mbx;
   virtual mul_if  _vif;
   virtual clk_if    clk_vif;
   event drv_done;

   function new();
      g0 = new;
      d0 = new;
      m0 = new;
      s0 = new;
      scb_mbx = new;
      drv_mbx = new;
   endfunction

   virtual task run();
      d0._vif = _vif;
      m0._vif = _vif;
      g0.clk_vif   = clk_vif;
      d0.clk_vif   = clk_vif;
      m0.clk_vif   = clk_vif;

      d0.drv_mbx = drv_mbx;
      g0.drv_mbx = drv_mbx;

      m0.scb_mbx = scb_mbx;
      s0.scb_mbx = scb_mbx;

      d0.drv_done = drv_done;
      g0.drv_done = drv_done;

      fork
         g0.run();
         d0.run();
         m0.run();
         s0.run();
      join_any;
   endtask
endclass

class test;
   env e0;
   mailbox drv_mbx;

   function new();
      drv_mbx = new();
      e0 = new();
   endfunction

   virtual task run();
      e0.d0.drv_mbx = drv_mbx;
      e0.run();
   endtask
endclass

interface mul_if();
   //logic       rstn;
   logic [3:0] a;
   logic [3:0] b;
   logic [7:0] y;
   //logic       carry;
endinterface

interface clk_if();
   logic tb_clk;

   initial begin
      tb_clk <= 0;
   end
   //initial tb_clk <= 0;

   always #10 tb_clk = ~tb_clk;
endinterface

module tb;
   bit tb_clk;
   clk_if m_clk_if();
   mul_if _if();
   //mul u0(_if.a,_if.b,_if.y);
//################################################## port connection by name
   mul u0(
      .a(_if.a),
      .b(_if.b),
      .y(_if.y));
//##################################################

   initial begin
      test t0;
      t0 = new;

      t0.e0._vif = _if;
      t0.e0.clk_vif = m_clk_if;
      t0.run();
      #50 $finish;
   end
endmodule
