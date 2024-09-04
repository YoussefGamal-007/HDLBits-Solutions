module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    // Pattern History Table (PHT)
    reg [1:0] PHT [127:0];
    integer i;
    
    // Internal wires for indices
    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Compute XOR indices
    assign predict_index = predict_history ^ predict_pc;
    assign train_index = train_history ^ train_pc;

    // Predict Taken Signal
    assign predict_taken = PHT[predict_index][1];

    // Combined Reset and Update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 7'd0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;  // Weakly not taken (01)
            end
        end else begin
            // Update Prediction History
            if (train_valid && train_mispredicted) begin
                predict_history <= {train_history[5:0], train_taken};
            end else if (predict_valid) begin
                predict_history <= {predict_history[5:0], predict_taken};
            end

            // Update PHT
            if (train_valid) begin
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
            end
        end
    end
endmodule
