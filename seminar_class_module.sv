module Game;
  
Beginner my_party[$];
  
Warrior w1;
Mage m1;
  
int num_Warrior = 2;  
int num_Mage = 3;
  
initial begin
  
  for(int i=0; i<num_Warrior; i++) begin
    w1 = new("Warrior","Sword",1,1,1);
    w1.randomize();
    my_party.push_back(w1);
  end

  for(int i=0; i<num_Mage; i++) begin
    m1 = new("Mage","Wand",1,1,1);
    m1.randomize();
    my_party.push_back(m1);
  end
  
  for(int i=0; i<my_party.size(); i++) begin
    my_party[i].attack();
  end
  
  for(int i=0; i<my_party.size(); i++) begin
    my_party[i].stat();
  end

  for(int i=0; i<my_party.size(); i++) begin
    my_party[i].levelup();
  end
  
  for(int i=0; i<my_party.size(); i++) begin
    my_party[i].stat();
  end

   $finish; 

end

endmodule
