module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2;
    reg [1:0] current_state, next_state;

    always @(*) begin
        case(current_state)
            S0:     next_state = x ? S1 : S0;
            S1:     next_state = x ? S2 : S1;
            S2:     next_state = x ? S2 : S1;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if(areset)begin
            current_state <= S0;
        end
        else begin
            current_state <= next_state;
        end
    end

    assign z = (current_state == S1);
    
endmodule