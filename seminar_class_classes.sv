
//Class 선언, 객체 생성, 멤버 변수 및 함수 정의
class Beginner;
   string name; 				// 캐릭터 이름
   int level;
   int STR;					//local int STR;	levelup 시 불가능 
   protected int DEX;		//자식 class에서 변경 가능
   int INT;					//보안화x : module에서 접근이 가능해서 문제 발생 가능
   rand int LUK;				//rand : 난수를 받을 수 있는 변수 생성
  
   static int total_num;   //총 캐릭터 수
   int id;
//   static int total_level;  //모든 캐릭터들의 레벨 합산
   

   constraint c_LUK { LUK inside {[1:10]}; }	//LUK 랜덤값 최대 최소
  
	
  function new(string name, int STR, int DEX, int INT);
      this.name = name;
      this.level = 1;
      create_charactor(STR, DEX, INT);
      
      total_num++;
      //total_level++;
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
     $display("%s's STAT \nlevel:\t%d\nSTR:\t%d\nDEX:\t%d\nINT:\t%d\nLUK:\t%d\n",name,level,STR,DEX,INT,LUK);
   endfunction

   virtual function levelup();
     $display("%s LEVEL UP!!\n", name); // 공격 방식 변경 
      level = level + 1;
      STR = STR + 1;
      DEX = DEX + 1;
      INT = INT + 1;
      LUK = LUK + 1;
      
 //     total_level += 1; // 전체 레벨 업데이트
   endfunction


endclass


//상속(Inheritance)
class Warrior extends Beginner;

   function new(string name, int STR, int DEX, int INT);
      super.new(name,STR, DEX, INT); // 부모 클래스인 Beginner의 생성자 호출 
   endfunction

   //다형성(Polymorphism)
   virtual function void attack();
      $display("%s Sword Attack!\n", name); // 공격 방식 변경 
   endfunction

   virtual function levelup();
     super.levelup();
      STR = STR + 2;
      DEX = DEX + 1;
   endfunction


endclass

class Mage extends Beginner;

   function new(string name, int STR, int DEX, int INT);
     super.new(name, STR, DEX, INT); 
   endfunction

   virtual function void attack();
      $display("%s Swing Wand!\n", name); // 공격 방식 변경 
   endfunction

   function void mage_skill();
      $display("%s Energy bolt!\n", name); // Mage 스킬
   endfunction 

   virtual function levelup();
      super.levelup();
      INT = INT + 2;
      LUK = LUK + 1;
   endfunction

endclass
