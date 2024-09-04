module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    reg [31:0] branch_register;
    always@(posedge clk or posedge areset) begin
        if(areset)
            branch_register <= 0;
        else if(train_mispredicted)
            branch_register <= {train_history[30:0] , train_taken};
        else if(predict_valid)
            branch_register <= {branch_register[30:0] , predict_taken} ;
    end
    
    assign predict_history = branch_register;
endmodule
