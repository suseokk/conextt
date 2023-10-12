//`include "design.sv"

module Game;
Beginner beginner_1;
Warrior w1;
Mage m1;

initial begin

   beginner_1 = new("Player",9,8,4);
   beginner_1.randomize; 
   beginner_1.attack(); 
   beginner_1.stat();
   beginner_1.STR = beginner_1.STR +1;
   beginner_1.stat();

   for (int i = 0; i < 2; i++) begin
      if(i == 0)
         w1 = new("Warrior",9,4,8);
      else
         w1 = new("Warrior",11,4,7);
      w1.randomize; 
      w1.attack();
      w1.stat();
      w1.levelup();
      w1.stat();
      w1.Total_Info();
   end


   beginner_1 = w1;                     //beginner_1에 w1 
   beginner_1.attack();


   m1 = new("Mage",4,4,10);
   m1.randomize;
   m1.attack();
   m1.mage_skill();
   m1.levelup();
   m1.stat();
   m1.Total_Info();
   

   $finish; 

end

endmodule
