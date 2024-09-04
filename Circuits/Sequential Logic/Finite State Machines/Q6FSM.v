module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
	
    // A,B,C..F >> 000001,000010,000100...100000
    parameter one = 1, two = 2 , three = 3 , four = 4 , five = 5 , six = 6;
    reg [6:1] state ;
    wire [6:1] next_state;
    
    always@(posedge clk) begin 
        if(reset)
            state <= one;
        else 
            state <= next_state;
    end 

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[one] =  state[1]&(w) | state[4]&(w);
    assign next_state[two] = state[1] & !w;
    assign next_state[three] =  state[2]&(~w) | state[6]&(~w);
    assign next_state[four] =  w & (state[2] | state[3] | state[5] | state[6]);
    assign next_state[five] =  state[3]&(~w) | state[5]&(~w);
    assign next_state[six] =  state[4]&(~w);
    
    // Output logic: 
    assign z = state[5] || state[6];
endmodule
