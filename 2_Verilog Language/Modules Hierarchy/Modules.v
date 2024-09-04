module top_module ( input a, input b, output out );

    mod_a instance2 ( .out(out), .in1(a), .in2(b) );
    
endmodule
