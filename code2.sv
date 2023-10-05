class human_class;
   string job;
   int id;
   static int inst_cnt;

   virtual task set_job;
      job = "A Farmer";
   endtask

   function new;
      this.set_job;
      this.id = inst_cnt++;
   endfunction

   task move(string target);
      $display("%s(%0d) has moved to %s", job, id, target);
   endtask

   task stop;
      $display("%s(%0d) has stopped." , job, id);
   endtask

   virtual task attak(string target);
      $display("%s(%0d) punched %s", job, id, target);
   endtask
endclass

human_fighter_class f0;
human_wizard_class w0;
human_archer_class a0;

human_class my_party[$];

initial begin

   for (int i = 0 ; i < 3 ; i++) begin
      f0 = new;
      my_party.push_back(f0); // fighter
   end
      
   for (int i = 0 ; i < 3 ; i++) begin
      w0 = new;
      my_party.push_back(w0); // wizard
   end

   for (int i = 0 ; i < 3 ; i++) begin
      a0 = new;
      my_party.push_back(a0); // archer
   end


   for (int i = 0; i< my_party.size(); i++) begin
      my_party[i]/stop();
   end

   for (int i = 0; i< my_party.size(); i++) begin
      my_party[i].move("Yanh Pyeong");
   end

   for (int i = 0; i< my_party.size(); i++) begin
      my_party[i].attack("rabbits");
   end
end
endmodule
