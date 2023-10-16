module Game;
  
  Beginner b0;
  
  Warrior w0;
  Mage m0;

  Beginner my_party[$];

	Total_Info tot_inf;

initial begin
  
  for (int i = 0 ; i < 2 ; i++) begin
    b0 = new();
    tot_inf = new();
    my_party.push_back(b0); // warrior
    //tot_inf.total_new_character();
   end
  
  foreach (my_party[i])
    my_party[i].to_in = tot_inf;
  

/*  for (int i = 0 ; i < 3 ; i++) begin
     w0 = new();
     my_party.push_back(w0); // warrior
   end

  for (int i = 0 ; i < 5 ; i++) begin
      m0 = new;
     my_party.push_back(m0); // mage
   end
*/

   for (int i = 0; i< my_party.size(); i++) begin
     my_party[i].stat();
   end

   for (int i = 0; i< my_party.size(); i++) begin
     my_party[i].attack();
   end

  
  foreach(my_party[i])begin
    if(my_party[i].job=="Beginner")begin
      for(int a=1;a<10;a++)
        my_party[i].levelup();
    end
  end
  
  
  foreach(my_party[i])begin
    if(my_party[i].job=="Beginner" && my_party[i].level>9)begin
      if(my_party[i].STR > my_party[i].INT) begin
        w0 = new();
        my_party.push_back(w0); // warrior 전직
        my_party[$].nickname = my_party[i].nickname;
        my_party[$].level = my_party[i].level;
        my_party[$].STR = my_party[i].STR;
        my_party[$].DEX = my_party[i].DEX;
        my_party[$].INT = my_party[i].INT;
        my_party[$].LUK = my_party[i].LUK;
        my_party[$].stat();
        //my_party[i]=null;
        //my_party[i].stat();
      end
      
      else begin
        m0 = new();
        my_party.push_back(m0); // mage 전직
        my_party[$].nickname = my_party[i].nickname;
        my_party[$].level = my_party[i].level;
        my_party[$].STR = my_party[i].STR;
        my_party[$].DEX = my_party[i].DEX;
        my_party[$].INT = my_party[i].INT;
        my_party[$].LUK = my_party[i].LUK;
        my_party[$].stat();
        //my_party[i]=null;
        //my_party[i].stat();
      end

    end
  end
  
  
  foreach(my_party[i])begin
    if(my_party[i].job=="Warrior")begin
      for(int a=1;a<3;a++)
        my_party[i].levelup();
    end
  end
 
  my_party[3].show_total_info();


end


endmodule
