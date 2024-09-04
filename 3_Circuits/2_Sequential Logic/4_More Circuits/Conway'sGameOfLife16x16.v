module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    reg [255:0] q_temp;
    integer row_up , row_down , col_right , col_left;
    always@(posedge clk) begin
        if(load)
			q_temp <= data;
        else begin
            for(int row = 0 ; row < 16 ; row = row + 1) begin
                for(int col = 0 ; col < 16 ; col = col + 1) begin 
                    if(row == 0)
                        row_up =15;
                    else
                        row_up = row - 1;
                    
                    if(row == 15)
                        row_down = 0;
                    else 
                        row_down = row + 1;
                    
                    if(col == 0)
                        col_left = 15;
                    else 
                        col_left = col - 1;
                    
                    if(col == 15)
                        col_right = 0;
                    else 
                        col_right = col + 1;
                    
                    if(q[16*row_up+col_left] + q[16*row_up+col] + q[16*row_up+col_right] + q[16*row_down+col_left]
                       + q[16*row_down+col] + q[16*row_down+col_right] + q[16*row+col_left] + q[16*row+col_right] == 2)
                        q_temp[16*row+col] <= q[16*row+col];
                    
                    else if(q[16*row_up+col_left] + q[16*row_up+col] + q[16*row_up+col_right] + q[16*row_down+col_left]
                       + q[16*row_down+col] + q[16*row_down+col_right] + q[16*row+col_left] + q[16*row+col_right] == 3)
                        q_temp[16*row+col] <= 1;
                    
                    else 
                        q_temp[16*row+col] <= 0;
                end 
            end 
        end 
    end 
    
    assign q = q_temp;
endmodule
