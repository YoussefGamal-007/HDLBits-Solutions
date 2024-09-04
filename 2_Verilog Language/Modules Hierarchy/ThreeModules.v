module top_module ( input clk, input d, output q );

    wire q1,q2;
    my_dff ff1 ( clk,  d,  q1 );
    my_dff ff2 ( clk, q1,  q2 );
    my_dff ff3 ( clk, q2,  q  );
endmodule
