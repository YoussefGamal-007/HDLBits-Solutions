module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
   // supply1 VCC;
    wire [4:1] enable;
    assign enable[1] = (ss[3:0] == 9) && ena;
    
    assign enable[2] = (ss[3:0] == 9) && (ss[7:4] == 5) && ena;
    assign enable[3] = (ss[3:0] == 9) && (ss[7:4] == 5) && (mm[3:0] == 9) && ena;
    
    assign enable[4] = (ss[3:0] == 9) && (ss[7:4] == 5) && (mm[3:0] == 9) && (mm[7:4] == 5) && ena;
    
    
    BCD_counter C0 (clk , reset , ena    , ss[3:0]);
    six_counter C1 (clk , reset , enable[1] , ss[7:4]);
    
    BCD_counter C2 (clk , reset , enable[2] , mm[3:0]);
    six_counter C3 (clk , reset , enable[3] , mm[7:4]);
    
    hour_counter C4 (clk , reset , enable[4] , ena, hh[7:0]);
    
    always@(posedge clk) begin
        if( (ss[3:0] == 9) && (ss[7:4] == 5) && (mm[3:0] == 9) && (mm[7:4] == 5) && (hh[3:0] == 1) && (hh[7:4] == 1)&& ena)
            pm <= !pm;
    end 
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

module six_counter (
    input clk,
    input reset,
    input enable,
    output reg [3:0] q);
    
    always@(posedge clk) begin
        if(reset || (q == 5 && enable))
            q <= 0;
        else if(enable)
            q <= q + 1;
    end 
endmodule

module hour_counter (
    input clk,
    input reset,
    input enable,
    input ena,
    output reg [7:0] q);
    
    always@(posedge clk) begin
        if(reset)
            q[3:0] <= 2;
        else if( q[3:0] == 9 && ena && enable)
            q[3:0] <= 0;
        else if(q[3:0] == 2 && q[7:4] == 1 && ena && enable)
            q[3:0] <= 1;
        else if(enable)
            q[3:0] <= q[3:0] + 1;
    end 
    
    wire ena1;
    assign ena1 = (q[3:0] == 9) && enable;
    always@(posedge clk) begin
        if(reset)
            q[7:4] <= 1;
        else if(q[3:0] == 2 && q[7:4] == 1 && ena && enable)
            q[7:4] <= 0;
        else if(ena1 && ena)
            q[7:4] <= q[7:4] + 1;
    end 
      
endmodule 