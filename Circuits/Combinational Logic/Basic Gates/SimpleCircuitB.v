module top_module ( input x, input y, output z );

    // if inputs are equal then output is high 
    // XNOR 
    xnor(z , x , y);
endmodule
