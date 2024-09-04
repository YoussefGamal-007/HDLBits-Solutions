module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    // even numbers of ones detector (XNOR)
    assign q = ~(a ^ b ^ c ^ d);

endmodule
