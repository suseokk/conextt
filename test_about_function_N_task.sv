module tb;

  int a, b, c;
  int tmp;

  //task test (int a, int b, output [31:0] c);
  //task test (input [31:0] a,b, output [31:0] c);
  function bit [31:0] test ( f_a, input int f_b, /**output**/ [31:0] f_c);
    f_c = f_a + f_b;
    //$display(a,b,c);
    return f_c + 5;
  endfunction

  initial begin
    a = 1;
    b = 2;

    test(a,b,c);
    $display("a : %d", c);
    $display("b : %d", tmp);

    tmp = test(a,b,c);
    $display("a` : %d", c);
    $display("b` : %d", tmp);
  end
endmodule
