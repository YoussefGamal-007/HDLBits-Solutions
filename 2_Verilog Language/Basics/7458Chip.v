module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
	
    // internal signals (implicit declerations)
    // you cant use implicit declerations as default nettype is set to "none"
    wire w1,w2,w3,w4;
    assign w1 = p2a & p2b;
    assign w2 = p1c & p1b & p1a;
    assign w3 = p2c & p2d;
    assign w4 = p1e & p1f & p1d;
    
    // outputs 
    assign p2y = w1 | w3;
    assign p1y = w2 | w4;

endmodule
