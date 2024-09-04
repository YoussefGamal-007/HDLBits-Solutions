module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done
); 

    parameter IDLE = 0 , START = 1 , DATA = 2 , STOP = 3 , DISCARD = 4;
    reg [2:0] state , next_state;
    
    always@(posedge clk) begin 
        if(reset)
            state <= IDLE;
        else 
            state <= next_state;
    end 
    
    always@* begin
        case(state)
            IDLE: next_state = in ? IDLE : START;
            START: next_state = DATA;
            DATA: begin 
                if(count == 7) 
                    if (in) next_state = STOP;
                	else next_state = DISCARD;
                else 
                    next_state = DATA;
            end 
            STOP: next_state = in ? IDLE : START ;
			DISCARD: next_state = in ? IDLE : DISCARD;
            default: next_state = IDLE;
        endcase
    end
    
    reg [3:0] count ;
    always@(posedge clk) begin
        if(reset)
            count <= 0;
        else if (count == 7)
            count <= 0;
        else if(state == DATA)
            count <= count + 1;
    end 
    
    assign done = (state == STOP);
endmodule
