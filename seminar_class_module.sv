module Game;

Beginner beginner_array[];
parameter BEGINNER_ARRAY_SIZE = 5;
Warrior warrior_array[];
parameter WARRIOR_ARRAY_SIZE = 10;
Mage mage_array[];
parameter MAGE_ARRAY_SIZE = 20;


//beginner 5명
initial begin 
   beginner_array = new[BEGINNER_ARRAY_SIZE];

   for (int i = 0; i < BEGINNER_ARRAY_SIZE; i++) begin
      beginner_array[i] = new(i);
      beginner_array[i].randomize;
   end

   for(int i = 0; i < BEGINNER_ARRAY_SIZE; i++)
      beginner_array[i].stat();
   end


   //Warrior 10명
   initial begin 
      warrior_array = new[WARRIOR_ARRAY_SIZE];

      for (int i = 0; i < WARRIOR_ARRAY_SIZE; i++) begin  
         warrior_array[i] = new(i);
         warrior_array[i].randomize;
      end

      for(int i = 0; i < WARRIOR_ARRAY_SIZE; i++) begin
         warrior_array[i].stat();
      end
   end


   //Mage 20명  
   initial begin 
      mage_array = new[MAGE_ARRAY_SIZE];

      for (int i = 0; i < MAGE_ARRAY_SIZE; i++) begin
         mage_array[i] = new(i);
         mage_array[i].randomize;
         mage_array[i].show_total_info();
      end

      for(int i = 0; i < MAGE_ARRAY_SIZE; i++) begin
         mage_array[i].stat();
      end
   end

   
initial begin
   warrior_array[3].attack();	
   mage_array[2].levelup();
   mage_array[2].show_total_info();


   $finish; 
end




endmodule
