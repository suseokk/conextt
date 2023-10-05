module Game;

  string name;
  string w1;
  string b1; 
  
  // Beginner attack
  task beginner_attack(string name);
    $display("%s attacks!", name);
  endtask
  
  // Warrior attack
  task warrior_attack(string name);
    $display("%s attacks with a sword!", name);
  endtask

   // Mage attack
   task mage_attack(string name);
     $display("%s casts a spell!", name); 
   endtask
   
   // 추가된 기능: 방어하기 
   
   // Beginner defense
   task beginner_defense(string name);
     $display("%s defends!", name); 
   endtask
   
   // Warrior defense
   task warrior_defense(string name);
     $display("%s defends with a shield!", name); 
   endtask
   
    // Mage defense
    task mage_defense(string_name);
      $display("%s casts a protection spell!", string_name); 
    endtask

initial begin

    
  	b1 = "Player"; 
    beginner_attack(b1); 
    beginner_defense(b1);

     
  	w1= "Warrior"; 
    warrior_attack(w1);
    warrior_defense(w1);

    
$finish; 

end

endmodule
