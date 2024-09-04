module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 
    // you pass each bits as it is till the first one 
    // pass the first one then invert everything after
    parameter pass = 0 , invert = 1;
    reg state , next_state ;
    
    // state memory
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= pass;
    	else
            state <= next_state;
    end 
    
    // next state logic
    always@* begin
        case(state)
            pass: next_state = x ? invert : pass;
            invert: next_state = x ? invert : invert;
            default: next_state = pass;
        endcase
    end 
    
    // output logic
    assign z = (state == pass) ? x: !x;
endmodule
