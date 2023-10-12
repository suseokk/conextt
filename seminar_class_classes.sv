//hi this is branch : branch_for_conextt
//`include "testbench.sv"

//Class 선언,e;
class Beginner;
   string name; 				// 캐릭터 이름
   int level;
   rand protected int STR;					//local int STR;	levelup 시 불가능 
   rand protected int DEX;		//자식 class에서 변경 가능
   rand protected int INT;					//보안화x : module에서 접근이 가능해서 문제 발생 가능
   rand protected int LUK;				//rand : 난수를 받을 수 있는 변수 생성
   static int total_num;   //총 캐릭터 수
   static int total_level;  //모든 캐릭터들의 레벨 합산

   constraint c { STR inside {[4:10]}; DEX inside {[4:10]}; INT inside {[4:10]}; LUK inside {[4:10]}; }

   function new(string name);
      this.name = name;
      this.level = 1;
      total_num++;
      total_level++;
   endfunction

   virtual function void attack();
      $display("%s basic attack !\n", name);
   endfunction

   function void stat();
      $display("%s's STAT \nlevel:%0d\nSTR:%0d\nDEX:%0d\nINT:%0d\nLUK:%0d\n",name,level,STR,DEX,INT,LUK);
   endfunction

   function levelup();
      level = level + 1;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;

      $display("%s LEVEL UP!!(LEVEL=%0d)\n", name, level); // 공격 방식 변경 

      total_level += 1; // 전체 레벨 업데이트
   endfunction

   function Total_Info();
      $display("total number : %0d\n", total_num);
      $display("total level : %0d\n", total_level);
   endfunction

endclass

class Warrior extends Beginner;

   function new(string name);
      super.new(name); // 부모 클래스인 Beginner의 생성자 호출 
   endfunction

   virtual function void attack();
      $display("%s Sword Attack!\n", name); // 공격 방식 변경 
   endfunction

	function void warrior_skill();
		$display("%s Power strike!\n", name);

   function levelup();
      super.levelup();
      STR = STR + 2;
      DEX = DEX + 1;
   endfunction

endclass

class Mage extends Beginner;

   function new(string name);
      super.new(name); 
   endfunction

   virtual function void attack();
      $display("%s Swing Wand!\n", name); // 공격 방식 변경 
   endfunction

   function void mage_skill();
      $display("%s Energy bolt!\n", name); // Mage 스킬
   endfunction 

   function levelup();
      super.levelup();
      INT = INT + 2;
      LUK = LUK + 1;
   endfunction

endclass
