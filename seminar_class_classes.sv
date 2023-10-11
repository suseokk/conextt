//hi this is branch : study_bjkim
//`include "testbench.sv"

//Class 선언, 객체 생성, 멤버 변수 및 함수 정의


class Total_Info;
   static int total_character_num;
   static int total_character_level;
  
  function new();
  endfunction

   virtual function new_character();
      total_character_num++;
      total_character_level++;
   endfunction

   function character_levelup();
      total_character_level += 1;
   endfunction

   function show_total_info();
     $display("total number : %d\n", total_character_num); 
     $display("total level : %d\n", total_character_level);
   endfunction
   
endclass



class Beginner;
   string job;
   int name; 				// 캐릭터 이름
   int level;
   rand int STR;					//local int STR;	levelup 시 불가능 
   rand protected int DEX;		//자식 class에서 변경 가능
   rand int INT;					//보안화x : module에서 접근이 가능해서 문제 발생 가능
   rand int LUK;				//rand : 난수를 받을 수 있는 변수 생성
   //static int total_num;   //총 캐릭터 수
   //static int total_level;  //모든 캐릭터들의 레벨 합산   

  constraint c_LUK { STR inside {[1:10]}; DEX inside {[1:10]}; INT inside {[1:10]}; LUK inside {[1:10]}; }	//LUK 랜덤값 최대 최소

  Total_Info to_in;
  
  
   
  function new(string job,string name);
      this.job = job;
      this.name = name;
      this.level = 1;
      this.to_in = new();
      //create_charactor();
      
      //total_num++;
      //total_level++;
        
    
      this.to_in.new_character();
   endfunction

//   function void create_charactor(int STR, int DEX, int INT);
//      this.STR = STR;
//      this.DEX = DEX;
//      this.INT = INT;
//      //this.LUK = LUK; 
//   endfunction

   virtual function void attack();
      $display("%s basic attack !\n", name);
   endfunction

   function void stat();
     $display("%s_%d's STAT \nlevel:%d\nSTR:%d\nDEX:%d\nINT:%d\nLUK:%d\n",job, name,level,STR,DEX,INT,LUK);
   endfunction

   function levelup();
      $display("%s LEVEL UP!!\n", name); // 공격 방식 변경 
      this.level++;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;
      
      //total_level += 1; // 전체 레벨 업데이트
   endfunction

   function show_total_info();
     this.to_in.show_total_info(); 
   endfunction
     
//   endfunction

endclass


class Warrior extends Beginner;

   function new(string name);
     super.new("warrior",name); // 부모 클래스인 Beginner의 생성자 호출 
   endfunction

   virtual function void attack();
      $display("%s Sword Attack!\n", name); // 공격 방식 변경 
   endfunction

   function levelup();
      super.levelup();
      STR = STR + 2;
      DEX = DEX + 1;
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


   
