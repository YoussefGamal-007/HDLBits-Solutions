module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter left = 0 , right = 1 , fall_r = 2 , fall_l = 3 , dig_r=4 , dig_l = 5;
    parameter splatter = 6;
    
    reg [2:0] state , next ;
    reg [99:0] count;
 
    //state flipflops 
    always@(posedge clk or posedge areset) begin 
        if (areset) state <= left ;
        else state <= next ;
    end 
 
    //timer clock 
    always@(posedge clk or posedge areset) begin
        if(areset) count <= 0;
        //else if (count == 20) 
          //  count <= 0;
        else if(state==fall_r || state==fall_l)
            count <= count + 1;
        else 
            count <= 0;
    end 
    //state transition logic 
    always@* begin 
        case(state) 
            left : next = (!ground) ? fall_l : (dig) ? dig_l : (bump_left) ? right : left ;
            right : next = (!ground) ? fall_r : (dig) ? dig_r : (bump_right) ? left : right ;   
            
            fall_l : next = (count >=20 && ground) ? splatter : (ground) ? left : fall_l ;
            fall_r : next = (count >=20 && ground) ? splatter : (ground) ? right : fall_r;       
                
            dig_r : next = (!ground) ? fall_r : dig_r;
            dig_l : next = (!ground) ? fall_l : dig_l;    
            splatter : next = splatter ;
            default : next = left ;
        endcase
    end 
    
    //output logic 
    assign walk_left = (state!=splatter) && (state==left);
    assign walk_right =  (state!=splatter) &&( state==right) ;
    assign aaah =  (state!=splatter) && (state==fall_r || state==fall_l) ;
    assign digging =  (state!=splatter) && (state==dig_r || state==dig_l);
    
endmodule

