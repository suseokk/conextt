//giggle test
//git-cola
//gitui
//gitfiend

module Game;
   Beginner my_party[$];
   Warrior w1;
   Mage m1;

   Total_info t1;

   //int num_Warrior = 102;
   int num_Warrior = 2; 
   //int num_Mage = 103;
   int num_Mage = 3;

   initial begin
      t1 = new;

      for(int i=0; i<num_Warrior; i++) begin
         w1 = new;
         w1.randomize();
         my_party.push_back(w1);
      end

      for(int i=0; i<num_Mage; i++) begin
         m1 = new;
         m1.randomize();
         my_party.push_back(m1);
      end

      for(int i=0; i<my_party.size(); i++) begin
         my_party[i].Info = t1;
      end
      
      for(int i=0; i<my_party.size(); i++) begin
         my_party[i].stat();
      end
      
      for(int i=0; i<my_party.size(); i++) begin
         my_party[i].attack();
      end
      
      for(int i=0; i<my_party.size(); i++) begin
         my_party[i].levelup();
         my_party[i].show_info();
      end
      
      for(int i=0; i<my_party.size(); i++) begin
         my_party[i].stat();
      end
      
      $finish;
   end
endmodule
