module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    reg [2:0] state , next_state;
    
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
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3;
            default: next_state = S0;
        endcase
    end 
    
    // output logic
    assign z = (state == S3) || (state == S4);
endmodule
