//hi this is branch : branch_for_conextt
//`include "testbench.sv"

//Class 선언, 객체 생성, 멤버 변수 및 함수 정의
class character;
   string name;
   string job;// 캐릭터 이름
   int level;
   int STR;					//local int STR;	levelup 시 불가능 
   int DEX;		//자식 class에서 변경 가능
   int INT;					//보안화x : module에서 접근이 가능해서 문제 발생 가능
   int LUK;				//rand : 난수를 받을 수 있는 변수 생성
   static int total_num;   //총 캐릭터 수
   static int total_level;  //모든 캐릭터들의 레벨 합산
   

   function new(string name);
      this.name = name;
      this.level = 1;
      this.STR = 5;
      this.DEX = 5;
      this.INT = 5;
      this.LUK = 5;
      total_num++;
      total_level++;
      this.set_job;
   endfunction

   task show_status;
      $display("%s[%s] : LEVEL[%0d] STR[%0d] DEX[%0d] INT[%0d] LUK[%0d]",
                  name, job, level, STR, DEX, INT, LUK );

   virtual task set_job;
      job = "beginner";
   endtask

   virtual task attack;
      $display("%s[%s] : <%d>damage basic attack!! ", name, job, STR*10);
   endtask

   virtual function LEVEL_UP;
      this.level= this.level + 1;
      total_level++;
      $display("%s[%s] : LEVEL UP!!! [lv.%0d] => [lv.%0d]", name, job, level-1, level);
      this.STR = this.STR + 3;
      this.DEX = this.DEX + 3;
      this.INT = this.INT + 3;
      this.LUK = this.LUK + 3;
   endfunction
endclass


/////////////////////////////////////
///////////////child/////////////////
/////////////////////////////////////

class Warrior extends character;
   function new(string name);
      super.new(name);
   endfunction

   virtual task set_job;
      job = "Worrior";
   endtask

   virtual task attack;
      $display("%s[%s] : <%d>damage Big Sword attack!! ", name, job, STR*17);
   endtask

   virtual function LEVEL_UP;
      super.LEVEL_UP;
      this.STR = this.STR + 5;
   endfunction
endclass


class Mage extends character;
   function new(string name);
      super.new(name);
   endfunction

   virtual task set_job;
      job = "Mage";
   endtask

   virtual task attack;
      $display("%s[%s] : <%d>damage Magic fire attack!! ", name, job, INT*17);
   endtask

   virtual function LEVEL_UP;
      super.LEVEL_UP;
      this.INT = this.INT + 5;
   endfunction
endclass














