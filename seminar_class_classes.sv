//Class 선언, 객체 생성, 멤버 변수 및 함수 정의
class Beginner;
   string name;            // 캐릭터 이름
   int level, STR, DEX, INT;
   rand int LUK;           //rand : 난수를 받을 수 있는 변수 생성
   static int total_num_c;   //총 캐릭터 수
   static int total_level; //모든 캐릭터들의 레벨 합산

   constraint c_LUK { LUK inside {[1:10]}; } //LUK 랜덤값 최대 최소

   function new(string name, int STR, int DEX, int INT);
      this.name = name;
      this.level = 1;
      this.STR = STR;
      this.DEX = DEX;
      this.INT = INT;
      total_num_c++;
      total_level++;
   endfunction

   virtual function void attack();
      $display("%s basic attack !\n", name);
   endfunction

   virtual function void stat();
      $display("%s's STAT\nlevel : %0d\nSTR  : %0d\nDEX  : %0d\nINT  : %0d\nLUK  : %0d\n",name,level,STR,DEX,INT,LUK);
   endfunction

   virtual function void levelup();
      $display("%s LEVEL UP!!\n", name); // 공격 방식 변경 
      level = level + 1;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;
      total_level += 1; // 전체 레벨 업데이트
   endfunction

   function void Total_Info();
      $display("total number of characters: %0d", total_num_c); 
      $display("total level : %0d\n", total_level);
   endfunction
endclass


//상속(Inheritance)
class Job extends Beginner;
   function new(string name, int STR, int DEX, int INT);
      super.new(name,STR, DEX, INT); // 부모 클래스인 Beginner의 생성자 호출 
   endfunction

   //다형성(Polymorphism)
   virtual function void attack();
      if(name == "Warrior")
         $display("%s Sword Attack!\n", name); // 공격 방식 변경 
      if(name == "Mage")
         $display("%s Swing Wand!\n", name); // 공격 방식 변경 
   endfunction

   virtual function void skill();
      if(name == "Mage")
         $display("%s Energy bolt!\n", name); // Mage 스킬
   endfunction 

   virtual function void levelup();
      super.levelup();
      if(name == "Warrior")
         STR = STR + 3;
      if(name == "Mage")
         INT = INT + 3;
   endfunction
endclass
