module class_test;
class human_class;
   int id;
   static int inst_cnt;

   function new;
      id = inst_cnt++;
   endfunction

   task print_id;
      $display("The Id of this is %0d", id);
   endtask

endclass

human_class human_array[];
parameter HUMAN_ARRAY_SIZE = 8;

initial begin
   human_array = new[HUMAN_ARRAY_SIZE];

   for (int i = 0; i < HUMAN_ARRAY_SIZE;i++)
      human_array[i] = new;

   for (int i = 0; i < HUMAN_ARRAY_SIZE; i++)
      human_array[i].print_id();
end
endmodule
