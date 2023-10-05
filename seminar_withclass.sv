//Class 선언, 객체 생성, 멤버 변수 및 함수 정의
class Beginner;
  string name; // 캐릭터 이름
  
  function new(string name);
    this.name = name;
  endfunction
  
  virtual function void attack();
    $display("%s attacks!", name);
  endfunction
  
endclass

//상속(Inheritance)
class Warrior extends Beginner;
  
   function new(string name);
     super.new(name); // 부모 클래스인 Beginner의 생성자 호출 
   endfunction
   
   //다형성(Polymorphism)
   virtual function void attack();
     $display("%s attacks with a sword!", name); // 공격 방식 변경 
   endfunction
   
endclass

class Mage extends Beginner;

   function new(string name);
     super.new(name); 
   endfunction
   
   virtual function void attack();
     $display("%s casts a spell!", name); // 공격 방식 변경 
   endfunction
   
endclass


module Game;
  Beginner b1;
  Warrior w1;
  Mage m1;

initial begin

    b1 = new("Player"); 
    b1.attack(); 

    w1 = new("Warrior"); 
    w1.attack();

    m1 = new("Mage");
    m1.attack();

$finish; 

end

endmodule

