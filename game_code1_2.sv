module class_test;
class human_class;
   int id;
   static int inst_cnt;

   function new;
      id =inst_cnt++;
   endfunction

   task print_id;
      $display("the id of this is %0d.", id);
   endtask

endclass

human_class h0, h1, h2, h3, h4, h5;

initial begin
   h0 = new;
   h1 = new;
   h2 = new;
   h3 = new;
   h4 = new;
   h5 = new;

   h0.print_id();
   h1.print_id();
   h2.print_id();
   h3.print_id();
   h4.print_id();
   h5.print_id();
end
endmodule


