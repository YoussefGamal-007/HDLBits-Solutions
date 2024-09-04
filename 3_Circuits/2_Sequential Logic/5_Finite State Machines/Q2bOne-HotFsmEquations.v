module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
); // 6 5 4 3 2 1  before
   // 5 4 3 2 1 0  now


    assign Y1 = y[0] & w;

    assign Y3 =  !w & (y[1] | y[2] | y[4] | y[5]);

endmodule
