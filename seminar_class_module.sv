module Game;
Beginner b0;
Job j0;
Beginner user[$];

initial begin
   //Set Characters
   //Beginner
   for (int i = 0; i < 1; i++) begin
      b0 = new("Beginner");
      b0.randomize;
      user.push_back(b0);
   end
   //Warrior
   for (int i = 0; i < 102; i++) begin
      j0 = new("Warrior");
      j0.randomize();
      user.push_back(j0);
   end
   //Mage
   for (int i = 0; i < 103; i++) begin
      j0 = new("Mage");
      j0.randomize;
      user.push_back(j0);
   end

   //Act Characters
   $display("\nSTART\n");
   for (int i = 0; i < user.size(); i++) begin
      user[i].stat();
      user[i].attack();
      user[i].skill();
      user[i].levelup();
      user[i].stat();
      user[i].Total_Info();
   end
   $finish;
end
endmodule
