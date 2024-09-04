module top_module();

    reg clk , in;
    reg [2:0] S;
    wire out;
    q7 UUT (clk , in , S , out);
    
    always #5 clk = !clk;
    
    initial begin
    in = 0 ; S =2 ; clk=0;
        
    #10 S = 6; 
    #10 S = 2;  in = 1;
    #10 S = 7;  in = 0;
    #10 S = 0;  in = 1;
    #30 in = 0; in = 0;
    end 
     
endmodule
