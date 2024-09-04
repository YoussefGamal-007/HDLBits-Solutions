module top_module (input x, input y, output z);

    wire z1,z2,z3,z4;
    assign z1 = (x^y) & x;
    assign z2 = x ~^ y;
    assign z3 = (x^y) & x;
    assign z4 = x ~^ y;
    
    wire z5,z6;
    assign z5 = z1 | z2;
    assign z6 = z3 & z4;
    
    assign z = z5 ^ z6;
    
endmodule
