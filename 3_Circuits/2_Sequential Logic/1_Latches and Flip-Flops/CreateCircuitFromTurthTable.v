module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    always@(posedge clk) begin
        case({j,k})
            0: Q <= Q;
            1: Q <= 0;
            2: Q <= 1;
            3: Q <= !Q;
            default: Q <= Q;
        endcase
    end
endmodule
