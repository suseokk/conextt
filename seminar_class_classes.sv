//hi this is branch : study_bjkim
//nametest : bumm
//emailtest : bumm@conextt.com

class Total_Info;
   static local int total_character_num;         //총 캐릭터의 수
   static local int total_character_level;      //캐릭터 레벨의 총 합

   virtual function total_new_character();      //새 캐릭터 생성 시 
      total_character_num++;                     //총 캐릭터 수 +1
      total_character_level++;                  //레벨 총 합 +1
   endfunction

   function total_character_levelup();         //캐릭터 레벨 업 시
      total_character_level += 1;               //레벨 총 합 +1
   endfunction

   function show_total_info();                  //총 정보 출력
     $display("total number : %d\n", total_character_num); 
     $display("total level : %d\n", total_character_level);
   endfunction
   
endclass



class Beginner;
   string job;                //직업 명
   int name; 				      // 캐릭터 명(숫자로 표현)
   int level;                 //특정 캐릭터의 레벨
   rand int STR;					//local int STR;	levelup 시 불가능 
   rand protected int DEX;		//자식 class에서 변경 가능
   rand int INT;					//보안화x : module에서 접근이 가능해서 문제 발생 가능
   rand int LUK;				   //rand : 난수를 받을 수 있는 변수 생성

   constraint c_LUK { STR inside {[1:10]}; DEX inside {[1:10]}; INT inside {[1:10]}; LUK inside {[1:10]}; }	//랜덤값 최대 최소

   Total_Info to_in;         //Total_Info class 
  
  function new(string job,string name);
      this.job = job;
      this.name = name;
      this.level = 1;
      this.to_in = new();

      this.to_in.total_new_character();
   endfunction

   virtual function void attack();
      $display("%s basic attack !\n", name);
   endfunction

   function void stat();
     $display("%s_%d's STAT \nlevel:%d\nSTR:%d\nDEX:%d\nINT:%d\nLUK:%d\n",job, name,level,STR,DEX,INT,LUK);
   endfunction

   function levelup();
      $display("%s_%d LEVEL UP!!\n",job, name); // 공격 방식 변경 
      this.level++;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;
      
      to_in.total_character_levelup(); // 전체 레벨 업데이트
   endfunction

   function show_total_info();
     this.to_in.show_total_info(); 
   endfunction
     

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


   
