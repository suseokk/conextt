module class_test;
class armor_class;
   string name;

   function new(string name);
      this.name = name;
   endfunction

   function show();
      $display("%s", this.name);
   endfunction
endclass

class human_class;
   string job;
   int id;
   static int inst_cnt;

   armor_class armor_queue[$];

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

   virtual task attack(string target);
      $display("%s(%0d) punched %s", job, id, target);
   endtask

   task add_armor(armor_class ai);
      armor_queue.push_back(ai);
   endtask

   task show_armor();
      $display("Armor list of %s(%0d)", job, id);
      if(armor_queue.size() == 0)
         $display("None!");
      else begin
         for (int i = 0; i < armor_queue.size(); i++)
            armor_queue[i].show();
      end
   endtask

   task print_id;
      $display("The Id of this is %0d", id);
   endtask

endclass

class human_wizard_class extends human_class;
   virtual task set_job;
      job = "A wizard";
   endtask

   virtual task attack(string target);
      $display("%s(%0d) spelled %s", job, id, target);
   endtask
endclass

class human_archer_class extends human_class;
   virtual task set_job;
      job = "A archer";
   endtask

   virtual task attack(string target);
      $display("%s(%0d) shot a bow %s", job, id, target);
   endtask
endclass

class human_fighter_class extends human_class;
   virtual task set_job;
      job = "A fighter";
   endtask

   virtual task attak(string target);
      $display("%s(%0d) swung his sword at %s", job, id, target);
   endtask
endclass

human_fighter_class f0;
human_wizard_class w0;
human_archer_class a0;
armor_class am0;

human_class my_party[$];

initial begin

   for (int i = 0 ; i < 3 ; i++) begin
      f0 = new;
      am0 = new("helmet");
      f0.add_armor(am0);
      am0 = new("shield");
      f0.add_armor(am0);
      am0 = new("leather armor");
      f0.add_armor(am0);
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
      my_party[i].stop();
   end

   for (int i = 0; i< my_party.size(); i++) begin
      my_party[i].move("Yanh Pyeong");
   end

   for (int i = 0; i< my_party.size(); i++) begin
      my_party[i].attack("rabbits");
   end

   for (int i = 0; i < my_party.size(); i++) begin
      my_party[i].show_armor();
   end
end
endmodule
