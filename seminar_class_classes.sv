// giggle test2
// git-cola
// gitui
// gitfiend
// gittgtt

class Total_info;
   static int total_num;
   static int total_level;

   task show;
      $display("Total Level is %0d\n", total_level);
   endtask
endclass

class Beginner;
   string job, weapon, skill; 
   int level;
   int STR, DEX, INT;					//local int STR;	levelup 시 불가능 
   rand int LUK; 				//rand : 난수를 받을 수 있는 변수 생성i
   int id;
   
   constraint c_LUK { LUK inside {[1:10]}; }	//LUK 랜덤값 최대 최소

   Total_info Info;

   task show_info;
      Info.show;
   endtask

   function new;
      job = "Beginner";
      weapon = "Basic attack !\n";
      skill = "has No skills !\n";

      level = 1;
      STR = 1;
      DEX = 1;
      INT = 1;
      id = Info.total_num++;
      Info.total_level++;
   endfunction

   function void attack();
      $display("%s(%0d)'s %s", job, id, weapon);
      $display("%s(%0d)'s %s", job, id, skill);
   endfunction

   function void stat();
      $display("%s(%0d)'s STAT \nlevel:\t%d\nSTR:\t%d\nDEX:\t%d\nINT:\t%d\nLUK:\t%d\n",job,id,level,STR,DEX,INT,LUK);
   endfunction

   virtual function void levelup();
      $display("%s(%0d) LEVEL UP!!\n", job, id);
      level = level + 1;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;

      Info.total_level += 1; // 전체 레벨 업데이트
   endfunction
endclass

//상속(Inheritance)
class Warrior extends Beginner;
   function new;
      super.new; 
      this.job = "Warrior";
      this.weapon = "Sword attack !\n";
      this.skill = "Slash blast !\n";
   endfunction

   virtual function void levelup();
      super.levelup();
      STR = STR + 2;
      DEX = DEX + 1;
   endfunction
endclass

class Mage extends Beginner;
   function new;
      super.new; 
      this.job = "Mage";
      this.weapon = "Wand attack !\n";
      this.skill = "Energy bolt !\n";
   endfunction

   virtual function void levelup();
      super.levelup();
      INT = INT + 2;
      LUK = LUK + 1;
   endfunction
endclass
