module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter S0 = 4'd0;  
    parameter S1 = 4'd1;
    parameter S2 = 4'd2;
    parameter S3 = 4'd3;
    parameter S4 = 4'd4;
    parameter S5 = 4'd5;
    parameter S6 = 4'd6;
    parameter DISCARD = 4'd8;
    parameter FLAG = 4'd9;
    parameter ERROR = 4'd10;
    
    reg [3:0] state , next_state;
    
    // state memory 
    always@(posedge clk) begin
        if(reset)
            state <= S0;
    	else 
            state <= next_state;
    end
    
    // next state logic 
    always@* begin
        case(state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : DISCARD;
            S6: next_state = in ? ERROR : FLAG;
            DISCARD: next_state = in ? S1 : S0;
            FLAG: next_state = in ? S1 : S0;
            ERROR: next_state = in ? ERROR : S0;
            default: next_state <= S0;
        endcase
    end 
    
    // output logic 
    assign disc = (state == DISCARD);
    assign flag = (state == FLAG);
    assign err  = (state == ERROR);
endmodule
