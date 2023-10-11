//hi this is branch : study_bjkim
//`include "testbench.sv"

//Class 선언, 객체 생성, 멤버 변수 및 함수 정의
class Beginner;
   string job;
   string name; 				// 캐릭터 이름
   int level;
   rand int STR;					//local int STR;	levelup 시 불가능 
   rand protected int DEX;		//자식 class에서 변경 가능
   rand int INT;					//보안화x : module에서 접근이 가능해서 문제 발생 가능
   rand int LUK;				//rand : 난수를 받을 수 있는 변수 생성
   static int total_num;   //총 캐릭터 수
   static int total_level;  //모든 캐릭터들의 레벨 합산
   

  constraint c_LUK { STR inside {[1:10]}; DEX inside {[1:10]}; INT inside {[1:10]}; LUK inside {[1:10]}; }	//LUK 랜덤값 최대 최소

   function new(string job,string name);
      this.job = job;
      this.name = name;
      this.level = 1;
      //create_charactor();
      
      total_num++;
      total_level++;
   endfunction

   function void create_charactor(int STR, int DEX, int INT);
      this.STR = STR;
      this.DEX = DEX;
      this.INT = INT;
      //this.LUK = LUK; 
   endfunction

   virtual function void attack();
      $display("%s basic attack !\n", name);
   endfunction

   function void stat();
      $display("%s's STAT \nlevel:%d\nSTR:%d\nDEX:%d\nINT:%d\nLUK:%d\n",name,level,STR,DEX,INT,LUK);
   endfunction

   function levelup();
      $display("%s LEVEL UP!!\n", name); // 공격 방식 변경 
      level = level + 1;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;
      
      total_level += 1; // 전체 레벨 업데이트
   endfunction

   function Total_Info();
      $display("total number : %d\n", total_num); 
      $display("total level : %d\n", total_level);
      
   endfunction

endclass


//상속(Inheritance)
class Warrior extends Beginner;

   function new(string name);
      super.new("warrior",name); // 부모 클래스인 Beginner의 생성자 호출 
   endfunction

   //다형성(Polymorphism)
   virtual function void attack();
      $display("%s Sword Attack!\n", name); // 공격 방식 변경 
   endfunction

   function levelup();
      $display("%s LEVEL UP!!\n", name); // 공격 방식 변경 
      STR = STR + 3;
      DEX = DEX + 2;
      INT = INT + 1;
      LUK = LUK + 1;
   endfunction


endclass

class Mage extends Beginner;

   function new(string name);
      super.new("Mage",name); 
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
