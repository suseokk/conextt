//`include "design.sv"

module Game;
  Beginner b1;
  Warrior w1;
  Mage m1;

initial begin

    b1 = new("Player",9,8,4);
	b1.randomize; 
    b1.attack(); 
  	b1.stat();
  	b1.STR = b1.STR +1;
  	b1.stat();
  
    w1 = new("Warrior",9,4,8);
	w1.randomize; 
    w1.attack();
    w1.stat();
 	w1.levelup();
	w1.stat();
  	
  
  	b1 = w1;
    b1.attack();

  
    m1 = new("Mage",4,4,10);
	m1.randomize;
    m1.attack();
    m1.mage_skill();
    m1.levelup();
    m1.stat();

$finish; 

end

endmodule



