module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    // you need 6 states 
    parameter S0 = 0,    // below bottom
    		  S1 = 1,    // between middle and bottom & previous level lower than current level (current lower than next)
    	      S2 = 2,    // between middle and bottom & previous level higher than current level (current higher than next)
    		  S3 = 3,    // between middle and top    & previous level higher than current level (current higher than next)
    		  S4 = 4,    // between middle and top    & previous level lower than current level (current lower than next)
              S5 = 5;    // above top
    
    reg [2:0] state , next_state;
    
    always@(posedge clk) begin
        if(reset)
            state <= S0;
        else 
            state <= next_state;
    end 
    
    always@* begin
        case(state)
            S0: next_state = s[1] ? S1 : S0; //
            S1: next_state = s[2] ? S4 : (!s[1] ? S0 : S1); //
            S2: next_state = s[2] ? S4 : (!s[1] ? S0 : S2);
            S3: next_state = s[3] ? S5 : (!s[2] ? S2 : S3);
            S4: next_state = s[3] ? S5 : (!s[2] ? S2 : S4);
            S5: next_state = s[3] ? S5 : S3;
            default: next_state = S0;
        endcase
    end
    
    assign dfr = (state == S0) || (state == S2) || (state == S3);
    assign fr3 = (state == S0);
    assign fr2 = (state == S0) || (state == S1) || (state == S2);
    assign fr1 = (state != S5);
        
endmodule
