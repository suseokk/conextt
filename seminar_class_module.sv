//`include "design.sv"

module Game;
Beginner beginner_1;
Warrior w1,w2;
Mage m1,m2,m3;

initial begin

   beginner_1 = new("Player",9,8,4);
   beginner_1.randomize; 
   beginner_1.attack(); 
   beginner_1.stat();
   beginner_1.STR = beginner_1.STR +1;
   beginner_1.stat();

   w1 = new("Warrior",9,4,8);
   w1.randomize; 
   w1.attack();
   w1.stat();
   w1.levelup();
   w1.stat();
   w1.Total_Info();

   w2 = new("Warrior",9,4,8);
   w2.randomize; 
   w2.attack();
   w2.stat();
   w2.levelup();
   w2.stat();
   w2.Total_Info();

   beginner_1 = w1;                     //beginner_1에 w1 
   beginner_1.attack();


   m1 = new("Mage",4,4,10);
   m1.randomize;
   m1.attack();
   m1.mage_skill();
   m1.levelup();
   m1.stat();
   m1.Total_Info();
   

   m2= new("Mage",4,4,10);
   m2.randomize;
   m2.attack();
   m2.mage_skill();
   m2.levelup();
   m2.stat();
   m2.Total_Info();

   m3= new("Mage",4,4,10);
   m3.randomize;
   m3.attack();
   m3.mage_skill();
   m3.levelup();
   m3.stat();
   m3.Total_Info();
   $finish; 

end

endmodule
