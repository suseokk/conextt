`include "seminar_class_classes.sv"

module Game;
Beginner beginner_1;
Warrior w1, w2;
Mage m1;

initial begin

   beginner_1 = new("Player");
   beginner_1.randomize; 
   beginner_1.stat();
	beginner_1.attack();
	beginner_1.levelup();
   beginner_1.stat();
	beginner_1.Total_Info();

   w1 = new("Warrior");
   w1.randomize;
   w1.stat();
	w1.attack();
	w1.warrior_skill();
   w1.levelup();
   w1.stat();
   w1.Total_Info();

   w2 = new("Warrior");
   w2.randomize;
   w2.stat();
	w2.attack();
	w2.warrior_skill();
   w2.levelup();
   w2.stat();
   w2.Total_Info();

   m1 = new("Mage");
   m1.randomize;
	m1.stat();
   m1.attack();
   m1.mage_skill();
   m1.levelup();
   m1.stat();
   m1.Total_Info();

   $finish; 

end

endmodule
