module top_module
#(
parameter width = 100
)
( 
    input [width-1:0] in,
    output [width-1:0] out
);
	genvar i;
    generate 
        for(i=0;i<width;i=i+1) begin : vector_reversal
            assign out[i] = in[width-1-i];
        end
    endgenerate 
endmodule
