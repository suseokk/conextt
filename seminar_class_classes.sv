//Class 선언, 객체 생성, 멤버 변수 및 함수 정의
class Beginner;
   string name;            // 캐릭터 이름
   //rand : 난수를 받을 수 있는 변수 생성
   int level;
   rand int STR, DEX, INT, LUK;
   static int inst_cnt;   //총 캐릭터 수
   static int total_level; //모든 캐릭터들의 레벨 합산
   int id;                 //character ID

   constraint c_STAT { STR inside {[4:10]}; DEX inside {[4:10]}; INT inside {[4:10]}; LUK inside {[4:10]};} //LUK 랜덤값 최대 최소

   function new(string name);
      this.name = name;
      this.level = 1;
      inst_cnt++;
      total_level++;
      id = inst_cnt;
   endfunction

   virtual function void attack();
      $display("%s(%0d) basic attack !\n", name,id);
   endfunction

   virtual function void skill();
      $display("%s(%0d) has no skill\n", name,id);
   endfunction

   virtual function void stat();
      $display("%s(%0d)'s STAT\nlevel : %0d\nSTR  : %0d\nDEX  : %0d\nINT  : %0d\nLUK  : %0d\n",name,id,level,STR,DEX,INT,LUK);
   endfunction

   virtual function void levelup();
      $display("%s(%0d) LEVEL UP!!\n", name,id); // 공격 방식 변경 
      level = level + 1;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;
      total_level += 1; // 전체 레벨 업데이트
   endfunction

   function void Total_Info();
      $display("total number of characters: %0d", inst_cnt); 
      $display("total level : %0d\n", total_level);
   endfunction
endclass


//상속(Inheritance)
class Job extends Beginner;
   function new(string name);
      super.new(name); // 부모 클래스인 Beginner의 생성자 호출 
   endfunction

   //다형성(Polymorphism)
   virtual function void attack();
      if(name == "Warrior")
         $display("%s(%0d) Sword Attack!\n", name,id); // 공격 방식 변경 
      else if(name == "Mage")
         $display("%s(%0d) Swing Wand!\n", name,id); // 공격 방식 변경 
   endfunction

   virtual function void skill();
      if(name == "Mage")
         $display("%s(%0d) Energy bolt!\n", name,id); // Mage 스킬
   endfunction 

   virtual function void levelup();
      super.levelup();
      if(name == "Warrior")
         STR = STR + 3;
      else if(name == "Mage")
         INT = INT + 3;
   endfunction
endclass
