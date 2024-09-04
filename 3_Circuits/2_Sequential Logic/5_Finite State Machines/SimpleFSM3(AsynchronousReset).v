module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state , next_state;

    //memory logic 
    always@(posedge clk or posedge areset) begin 
        if(areset)
            state<=A;
        else
            state <= next_state;
    end 
    // State transition logic: next_state = f(state, in)
    always @* begin 
        case(state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A ;
        endcase 
    end 

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state==D);

endmodule
