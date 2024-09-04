module top_module(
    input  clk,
    input  reset,
    input  w,
    output  z
);
    // Define state parameters
    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;
    parameter F = 3'd5;

    // State variables
    reg [2:0] state, next_state;

    // State memory (sequential logic)
    always @(posedge clk) begin
        if (reset)
            state <= A;  // Reset to state A
        else
            state <= next_state;  // Update to next state
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            A: if (w) next_state = B; else next_state = A;
            B: if (w) next_state = C; else next_state = D;
            C: if (w) next_state = E; else next_state = D;
            D: if (w) next_state = F; else next_state = A;
            E: if (w) next_state = F; else next_state = A;
            F: if (w) next_state = C; else next_state = D;
            default: next_state = A;  // Default to state A
        endcase
    end

    // Output logic (continuous assignment)
    assign z = (state == F) || (state ==E);

endmodule

