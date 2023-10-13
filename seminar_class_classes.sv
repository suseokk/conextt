//design.sv에 첨가
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
      $display("total number : %0d\n", total_character_num); 
      $display("total level : %0d\n", total_character_level);
   endfunction
   
endclass



class Beginner;
   string job;                //직업 명
   int id; 				      // 캐릭터 명(숫자로 표현)
  	randc int nickname;
   int level;                 //특정 캐릭터의 레벨
   rand int STR;					//local int STR;	levelup 시 불가능 
   rand int DEX;		//자식 class에서 변경 가능
   rand int INT;					//보안화x : module에서 접근이 가능해서 문제 발생 가능
   rand int LUK;				   //rand : 난수를 받을 수 있는 변수 생성

   string weapon;
  
  static int char_cnt;

   constraint c_STAT { STR inside {[1:10]}; DEX inside {[1:10]}; INT inside {[1:10]}; LUK inside {[1:10]}; }	//랜덤값 최대 최소
  constraint c_NICKNAME { STR inside {[10000:99999]};}	//랜덤값 최대 최소

   Total_Info to_in;         //Total_Info class 

   virtual function set_job();
      this.job="Beginner";
   endfunction

   virtual function set_weapon();
      this.weapon="fist";
   endfunction
  
     
  
  function new();
    
      this.set_job;
     this.set_weapon;
      level = 1;

  
    nickname = $urandom_range(10000,99999);
    
    STR = $urandom_range(1,10);
    DEX = $urandom_range(1,10);
    INT = $urandom_range(1,10);
    LUK = $urandom_range(1,10);

     
      
      this.to_in = new();
    
      this.id = char_cnt++;

      //this.to_in.total_new_character();
   endfunction

   virtual function void attack();
     $display("%s_%0d%0d %s attack !\n",job, id, nickname, weapon);
   endfunction
  

   function void stat();
     $display("%s_%0d's STAT \n nickname:%0d\n level:%0d\n STR:%0d\n DEX:%0d\n INT:%0d\n LUK:%0d\n",job, id,nickname,level,STR,DEX,INT,LUK);
   endfunction

  
   virtual function levelup();
      this.level++;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;
     
     $display("%s_%0d, nickname:%0d LEVEL UP!!\n",job, id, nickname,);
     stat();
      
      to_in.total_character_levelup(); // 전체 레벨 업데이트
   endfunction

   function show_total_info();
     this.to_in.show_total_info(); 
   endfunction
     

endclass


class Warrior extends Beginner;
   
   virtual function set_job();
      this.job="Warrior";
   endfunction

   virtual function set_weapon();
      this.weapon="Sword";
   endfunction
  
   function new();
     super.new(); // 부모 클래스인 Beginner의 생성자 호출 
      this.set_job();
      this.set_weapon();
      $display("%0d's job change %s to %s\n",this.nickname,"Beginner",this.job);
   endfunction

   virtual function levelup();
      super.levelup();
      STR = STR + 2;
      DEX = DEX + 1;
   endfunction

endclass


class Mage extends Beginner;
     
   virtual function set_job();
      this.job="Mage";
   endfunction

   virtual function set_weapon();
      this.weapon="Wand";
   endfunction
  

   function new();
     super.new();
      this.set_job();
      this.set_weapon();
     $display("%0d's job change %s to %s\n",nickname,"Beginner",this.job);
   endfunction


   function void mage_skill();
     $display("%s_%0d nickname:%0d Energy bolt!\n",job, id, nickname); // Mage 스킬
   endfunction 

  
   virtual function levelup();
      super.levelup();
      INT = INT + 2;
      LUK = LUK + 1;
   endfunction

endclass


   
