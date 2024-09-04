module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
	
    wire [99:0] cout1;
    bcd_fadd  unit(a[3:0] , b[3:0] , cin , cout1[0] ,sum[3:0] );
    genvar i;
    generate 
        for(i=4;i<400;i=i+4)
            begin : adder
                bcd_fadd inst(a[i+3:i] ,b[i+3:i] ,cout1[i/4 -1]  ,cout1[i/4],sum[i+3:i] );
            end
    endgenerate
    assign cout = cout1[99];
endmodule
