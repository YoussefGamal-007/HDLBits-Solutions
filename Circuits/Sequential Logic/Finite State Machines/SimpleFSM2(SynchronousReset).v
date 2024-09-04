module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  
    
    parameter ON = 1,OFF = 0;
    reg current , next ;
    
    //memory element 
    always @(posedge clk)begin 
        if (reset)
            current <= OFF;
        else 
            current <= next;
    end
    
    //state trasnition logic 
    always @* begin
        case(current)
            OFF: next = j ? ON : OFF;
            ON : next = k ? OFF : ON ;
            default : next = OFF;
        endcase 
    end 
                
    //output logic 
    assign out = current;

endmodule