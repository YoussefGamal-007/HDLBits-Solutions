module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    // Define the states as parameters
    parameter S0  = 4'd0;  
    parameter S1  = 4'd1;
    parameter S2  = 4'd2;
    parameter S3  = 4'd3;
    parameter S4  = 4'd4;
    parameter S5  = 4'd5;
    parameter S6  = 4'd6;
    parameter S7  = 4'd7;
    parameter S8  = 4'd8;
    parameter S9  = 4'd9;
    parameter S10 = 4'd10;
    parameter S11 = 4'd11;

    // State variables
    reg [3:0] state, next_state;  
    
    //state memory
    always@(posedge clk) begin
        if(!resetn)
            state <= S0;
        else
            state <= next_state;
    end 
    
    // next state logic 
    always@* begin
        case(state)
            S0: next_state = S1;
            S1: next_state = S11;
            S11: next_state = x ? S2 : S3;
            S2: next_state = x ? S2 : S4;
            S3: next_state = x ? S2 : S3;
            S4: next_state = x ? S5 : S3;
            S5: next_state = y ? S7 : S6;
            S6: next_state = y ? S9 : S10;
            S7: next_state = y ? S9 : S8;
            S8: next_state = S8;
            S9: next_state = S9;
            S10: next_state = S10;
            default: next_state = S0;
        endcase
    end

    // need to put intermediate state btw S1 and going to S2 and S3 which will be S11 
    // because you need to have one free cycle after F = 1 before start monitoring x
    
    // output logic 
    assign f = state == S1;
    assign g = (state == S8) || (state == S9) || (state == S5) || (state == S6) || (state == S7);
endmodule
