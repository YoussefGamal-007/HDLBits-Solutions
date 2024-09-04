module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b_xored;
	// 2 ways to model the 1's complement condition
     assign b_xored = sub ? ~b : b;
    //assign b_xored = { b ^ {32{sub}} };
    
    wire cout1;
    add16 (a[15:0],  b_xored[15:0], sub, sum[15:0], cout1);
    add16 (a[31:16], b_xored[31:16], cout1, sum[31:16],  );
endmodule
