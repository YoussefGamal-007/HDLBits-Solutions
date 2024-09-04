module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    ////////////////////////////////////////////////// FSM from fsm_ps2 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
    // states declerations
    parameter BYTE1 = 0,
    		  BYTE2 = 1,
    		  BYTE3 = 2,
              DONE  = 3;
    reg [1:0] state , next_state;
    
    // State transition logic (combinational)
	always@* begin
        case(state)
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = in[3] ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end
    
    // State flip-flops (sequential)
    always@(posedge clk) begin
        if(reset)
            state <= BYTE1;
        else
            state <= next_state;
    end
    
    // Output logic
    assign done = (state == DONE);
    
    /////////////////////////////////////// New: Datapath to store incoming bytes \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    reg [7:0] temp_byte1 , temp_byte2 , temp_byte3;
    always@(posedge clk) begin
        if( (state == BYTE1) || (state == DONE && in[3]) )
            temp_byte1 <= in;
        else if(state == BYTE2)
            temp_byte2 <= in;
        else if(state == BYTE3)
            temp_byte3 <= in;
    end
            
    assign out_bytes = {temp_byte1 , temp_byte2 , temp_byte3};
endmodule
