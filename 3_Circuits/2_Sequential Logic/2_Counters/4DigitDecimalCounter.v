module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    supply1 VCC;
    assign ena[1] = (q[3:0] == 9);
    assign ena[2] = (q[3:0] == 9) && (q[7:4] == 9);
    assign ena[3] = (q[3:0] == 9) && (q[7:4] == 9) && (q[11:8] == 9);
    BCD_counter C0 (clk , reset , VCC    , q[3:0]);
    BCD_counter C1 (clk , reset , ena[1] , q[7:4]);
    BCD_counter C2 (clk , reset , ena[2] , q[11:8]);
    BCD_counter C3 (clk , reset , ena[3] , q[15:12]);
endmodule

module BCD_counter (
    input clk,
    input reset,
    input enable,
    output reg [3:0] q);
    
    always@(posedge clk) begin
        if(reset || (q == 9 && enable))
            q <= 0;
        else if(enable)
            q <= q + 1;
    end 
endmodule 