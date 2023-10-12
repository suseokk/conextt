`include "seminar_class_classes.sv"

module Game;
Beginner beginner_1;
Warrior warrior_array[];
Mage mage_array[];
parameter WARRIOR_ARRAY_SIZE = 100;
parameter MAGE_ARRAY_SIZE = 200;

initial begin

   beginner_1 = new("Player");
   beginner_1.randomize; 
   beginner_1.stat();
	beginner_1.attack();
	beginner_1.levelup();
   beginner_1.stat();
	beginner_1.Total_Info();

	warrior_array = new[WARRIOR_ARRAY_SIZE];
	for (int i=0; i<WARRIOR_ARRAY_SIZE; i++) begin
   	warrior_array[i] = new("Warrior");
   	warrior_array[i].randomize;
   	warrior_array[i].stat();
		warrior_array[i].attack();
		warrior_array[i].warrior_skill();
   	warrior_array[i].levelup();
   	warrior_array[i].stat();
   	warrior_array[i].Total_Info();
	end

	mage_array = new[MAGE_ARRAY_SIZE];
	for int j=0; j<MAGE_ARRAY_SIZE; j++) begin
   	mage_array[i] = new("Mage");
   	mage_array[i].randomize;
		mage_array[i].stat();
   	mage_array[i].attack();
   	mage_array[i].mage_skill();
   	mage_array[i].levelup();
   	mage_array[i].stat();
   	mage_array[i].Total_Info();
	end

	$finish;

end

endmodule
