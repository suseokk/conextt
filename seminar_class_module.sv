//`include "design.sv"

module Game;
character my_party[$];

Warrior  w0;
Mage     m0;

initial begin
   for (int i = 0; i <100;, i++) begin
      w0 = new;
      my_party.push_back(w0);
   end

   for (int i = 0; i<200;, i++) begin
      m0 = new;
      my_party.push.push_back(m0);
   end

   for (int i = 0; i < my_party.size(); i++) begin
      my_party[i].show_status;
      for(int j = 0; j<my_party[i].level+1; j++) begin
         my_party[i].attack;
      end
      my_party[i].LEVEL_UP;
   end
end

endmodule
