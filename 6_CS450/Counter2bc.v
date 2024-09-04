module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);

    parameter SNT = 0 , WNT = 1 , WT = 2 , ST = 3;
    reg [1:0] s , ns;  // state , next_state
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            s <= WNT;
        else 
            s <= ns;
    end 
    
    always@* begin
        case(s)
            SNT: ns = (!train_valid) ? SNT : (train_taken) ? WNT : SNT; 
            WNT: ns = (!train_valid) ? WNT : (train_taken) ? WT  : SNT; 
            WT:  ns = (!train_valid) ? WT  : (train_taken) ? ST  : WNT; 
            ST:  ns = (!train_valid) ? ST  : (train_taken) ? ST  : WT; 
            default: ns = WNT;
        endcase
    end
    
    assign state = s;
endmodule
