class Beginner;
   string job; 
	int level;
	int STR, DEX, INT;					//local int STR;	levelup 시 불가능 
	rand int LUK; 				//rand : 난수를 받을 수 있는 변수 생성
  
	static int total_num;   //총 캐릭터 수
	int id;
	//static int total_level;  //모든 캐릭터들의 레벨 합산
   
	constraint c_LUK { LUK inside {[1:10]}; }	//LUK 랜덤값 최대 최소
	
	function new;
		job = "Beginner";
		weapon = "Basic attack !\n";

		level = 1;
		STR = 1;
		DEX = 1;
		INT = 1;
		id = total_num++;
    		//total_level++;
	endfunction

	virtual function void attack();
		$display("%s(%0d)'s %s", job, id, weapon);
	endfunction

	function void stat();
		$display("%s(%0d)'s STAT \nlevel:\t%d\nSTR:\t%d\nDEX:\t%d\nINT:\t%d\nLUK:\t%d\n",job,id,level,STR,DEX,INT,LUK);
	endfunction

	virtual function levelup();
		$display("%s(%0d) LEVEL UP!!\n", job, id);
		level = level + 1;
		STR = STR + 1;
		DEX = DEX + 1;
		INT = INT + 1;
		LUK = LUK + 1;
      
 		//total_level += 1; // 전체 레벨 업데이트
	endfunction
endclass

//상속(Inheritance)
class Warrior extends Beginner;

	function new;
		super.new; 
		this.job = "Warrior";
		this.weapon = "Sword attack !\n";
	endfunction

	virtual function levelup();
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
	endfunction

	virtual function levelup();
		super.levelup();
		INT = INT + 2;
		LUK = LUK + 1;
	endfunction
endclass
