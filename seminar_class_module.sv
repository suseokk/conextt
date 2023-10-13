module Game;
Beginner b0;
Warrior  w0;
Mage     m0;
Beginner user[$];
total_info Info;

initial begin
   Info = new;
   //Set Characters
   //Beginner
   for (int i = 0; i < 1; i++) begin
      b0 = new;
      b0.randomize;
      user.push_back(b0);
   end
   //Warrior
   //for (int i = 0; i < 102; i++) begin
   for (int i = 0; i < 102; i++) begin
      w0 = new;
      w0.randomize();
      user.push_back(w0);
   end
   //Mage
   //for (int i = 0; i < 103; i++) begin
   for (int i = 0; i < 103; i++) begin
      m0 = new;
      m0.randomize;
      user.push_back(m0);
   end

   foreach (user[i])
      user[i].Info = Info;

   //Act Characters
   $display("\nSTART\n");
   for (int i = 0; i < user.size(); i++) begin
      user[i].stat();
      user[i].attack();
      user[i].skill();
      user[i].levelup();
      user[i].stat();
      user[i].show_total_info();
   end
   $finish;
end
endmodule
