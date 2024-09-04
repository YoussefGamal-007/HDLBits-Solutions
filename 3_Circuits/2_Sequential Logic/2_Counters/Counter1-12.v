module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    count4 the_counter (clk, c_enable, c_load, c_d );
    always@(posedge clk) begin
        if(reset || Q == 12 && enable)
            Q <= 1;
        else if(enable)
            Q <= Q + 1;
    end
    
    assign c_enable = enable; 
    assign c_load = (reset || (Q == 12 && enable));
    assign c_d = c_load ? 1 : 0;

endmodule
