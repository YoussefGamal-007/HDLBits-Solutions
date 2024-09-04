module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
	
    full_adder unit(a[0] , b[0] , cin , cout[0] , sum[0]);
    genvar i;
    generate 
        for(i=1;i<100;i=i+1)
            begin : adder
                full_adder inst(a[i] ,b[i] ,cout[i-1] ,cout[i] ,sum[i]);
            end
    endgenerate
endmodule

module full_adder (
    input a , b , cin,
    output cout , sum
);
    assign {cout,sum} = a + b + cin;
endmodule
