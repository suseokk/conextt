module mul(
   input[3:0] a,b,
   output[7:0] y
);

   assign y = a * b;
endmodule
/**
module mul(mul_if _if);
   assign _if.y = _if.a * _if.b;
endmodule
**/
