module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
//  2 , 3 , 5 , 7
// 010,011,101,111
// a=x3 , b=x2 , c=x1
// f = !a b !c + !a b c + a !b c + a b c    >> before optimization
// f = !a b + a c  >> after optimization
    
    assign f = (!x3 & x2) | (x3 & x1);
endmodule
