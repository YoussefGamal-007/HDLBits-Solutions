module top_module( 
    input [7:0] in,
    output [7:0] out
);
	genvar i;
    generate 
        for(i=0;i<8;i=i+1) begin : vector_reversal
            assign out[i] = in[7-i];
        end
    endgenerate 
endmodule
