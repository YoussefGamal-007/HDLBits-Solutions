module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    parameter A = 0 , B = 1 , C = 2 , D = 3;
    reg [2:0] state , next_state;
    
    // state memory
    always@(posedge clk) begin
        if(!resetn)
            state <= A;
        else
            state <= next_state;
    end 
    
    // next state logic
    always@* begin
        case(state)
            A: begin
                if(r[1]) next_state = B;
                else if (r[2]) next_state = C;
                else if(r[3]) next_state = D;
                else next_state = A;
            end 
            B: next_state = r[1] ? B : A;
            C: next_state = r[2] ? C : A;
            D: next_state = r[3] ? D : A;
            default: next_state = A;
        endcase
    end 
    
    // output logic
    assign g = {state == D , state == C , state == B};
endmodule
