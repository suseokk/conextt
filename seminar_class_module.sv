module Game;
  
  Warrior w0;
  Mage m0;

  Beginner my_party[$];

initial begin

  for (int i = 0 ; i < 3 ; i++) begin
     w0 = new();
     my_party.push_back(w0); // warrior
   end

  for (int i = 0 ; i < 5 ; i++) begin
      m0 = new;
     my_party.push_back(m0); // mage
   end


   for (int i = 0; i< my_party.size(); i++) begin
     my_party[i].stat();
   end

   for (int i = 0; i< my_party.size(); i++) begin
     my_party[i].attack();
   end

   for (int i = 0; i< my_party.size(); i++) begin
     my_party[i].levelup();
   end
  
  
  my_party[1].show_total_info();
  
  foreach(my_party[i].level)


end


endmodule
