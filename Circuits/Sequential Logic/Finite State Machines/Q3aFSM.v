module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);
    // Define the states as parameters
    parameter S0 = 4'd0;   // A
    parameter S1 = 4'd1;   // B
    parameter S2 = 4'd2;
    parameter S3 = 4'd3;
    parameter S4 = 4'd4;
    parameter S5 = 4'd5;
    parameter S6 = 4'd6;
    parameter S7 = 4'd7;
    parameter S8 = 4'd8;
    parameter S9 = 4'd9;

    reg [3:0] state , next_state ;
    
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
            S0: next_state = s ? S1 : S0;
            S1: next_state = w ? S2 : S8;
            S2: next_state = w ? S4 : S7;
            S3: next_state = w ? S5 : S1;
            S4: next_state = w ? S1 : S6;
            S5: next_state = w ? S2 : S8;
            S6: next_state = w ? S2 : S8;
            S7: next_state = w ? S5 : S1;
            S8: next_state = w ? S3 : S9;
            S9: next_state = w ? S1 : S1;
            default: next_state = S0;
        endcase
    end

    // output logic 
    assign z = (state == S5) || (state == S6);
    
   // always@(posedge clk)
     //   z <= (state == S7) | (state == S6);
endmodule
