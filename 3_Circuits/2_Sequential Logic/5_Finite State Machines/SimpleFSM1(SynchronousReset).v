// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;

    // Fill in state name declarations
    localparam B=1 , A=0;

    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            next_state = B;
        end else begin
            case (present_state)
                // Fill in state transition logic
                A: next_state = in ? A : B;
                B: next_state = in ? B : A;
            endcase
        end 
            // State flip-flops
            present_state <= next_state;  
    end
	assign out = present_state;
endmodule
