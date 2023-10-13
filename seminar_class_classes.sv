class total_info;
   static int inst_cnt;   //it can be total number of characters
   static int total_level;

   function void show();
      $display("total number of characters : %0d", inst_cnt); 
      $display("total level : %0d\n", total_level);
   endfunction
endclass


class Beginner;
   string name, attack_act, skill_act;
   int level;
   //rand : 난수를 받을 수 있는 변수 생성
   rand int STR, DEX, INT, LUK;
   int id;                 //character ID

   constraint c_STAT { STR inside {[4:10]}; DEX inside {[4:10]}; INT inside {[4:10]}; LUK inside {[4:10]};}

   total_info Info;

   function new();
      this.name = "Beginner";
      this.attack_act = "'s fist attack!";
      this.skill_act = " has no skill!";
      this.level = 1;
      Info.inst_cnt++;
      Info.total_level++;
      id = Info.inst_cnt;
   endfunction

   //virtual function void attack();
   function void attack();
      $display("%s(%0d)%s\n", name,id,attack_act);
   endfunction

   //virtual function void skill();
   function void skill();
      $display("%s(%0d)%s\n", name,id,skill_act);
   endfunction

   virtual function void stat();
      $display("%s(%0d)'s STAT\nlevel : %0d\nSTR  : %0d\nDEX  : %0d\nINT  : %0d\nLUK  : %0d\n",name,id,level,STR,DEX,INT,LUK);
   endfunction

   virtual function void levelup();
      $display("%s(%0d) LEVEL UP!!\n", name,id);
      level       += 1;
      Info.total_level += 1;
      STR += 1;
      DEX += 1;
      INT += 1;
      LUK += 1;
   endfunction

   task show_total_info();
      Info.show();
   endtask
endclass


//상속(Inheritance)
class Warrior extends Beginner;
   function new();
      super.new;
      this.name = "Warrior";
      this.attack_act = "'s sword attack!";
      this.skill_act = "'s power strike!";
   endfunction
   virtual function void levelup();
      super.levelup();
      STR = STR + 3;
   endfunction
endclass


class Mage extends Beginner;
   function new();
      super.new;
      this.name = "Mage";
      this.attack_act = "'s staff attack!";
      this.skill_act = " spelled lightning bolt!";
   endfunction

   virtual function void levelup();
      super.levelup();
      INT = INT + 3;
   endfunction
endclass
