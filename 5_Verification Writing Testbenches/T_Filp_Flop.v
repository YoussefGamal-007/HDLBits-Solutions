module top_module ();
    reg clk , reset , t;
    wire q;

    tff DUT (clk , reset , t , q);
    
    always #5 clk = !clk;
    initial begin 
        clk = 0 ; reset = 0 ; t = 1;
        #2 reset = 1;
        #4 reset = 0;
    end 
endmodule
