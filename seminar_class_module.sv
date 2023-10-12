module Game;
Beginner b0;
Job j0;

initial begin
   $display("\nSTART\n");
   b0 = new("Player",9,8,4);
   b0.randomize; 
   b0.stat();
   b0.attack(); 
   b0.STR = b0.STR +1;
   b0.stat();

   for (int i = 0; i < 2; i++) begin
      if(i == 0)
         j0 = new("Warrior",9,4,8);
      else
         j0 = new("Warrior",11,4,7);
      j0.randomize; 
      j0.stat();
      j0.attack();
      j0.levelup();
      j0.stat();
      j0.Total_Info();
   end


   b0 = j0;                     //b0에 j0 
   b0.attack();


   for (int i = 0; i < 3; i++) begin
      if(i == 0)
         j0 = new("Mage",4,4,10);
      else if(i == 1)
         j0 = new("Mage",4,6,10);
      else
         j0 = new("Mage",6,4,11);
      j0.randomize;
      j0.stat();
      j0.attack();
      j0.skill();
      j0.levelup();
      j0.stat();
      j0.Total_Info();
   end
   $finish; 
end
endmodule
