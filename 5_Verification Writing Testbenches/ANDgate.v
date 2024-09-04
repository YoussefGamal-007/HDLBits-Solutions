module top_module();

    reg [1:0] in;
    wire out;
    andgate UUT (in , out);
    
    initial begin
        in = 0;
        repeat(3) begin
            #10 in = in + 1;
        end 
    end 
endmodule
