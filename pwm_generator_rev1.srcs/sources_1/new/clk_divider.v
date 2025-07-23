module clk_divider (
    input clk_in,
    input rst,
    output reg clk_out
);

    reg[31:0] counter = 32'd0;
    parameter divisor = 32'd2;
    
    always @(posedge clk_in or posedge rst) begin
        if (rst) 
            clk_out <= 0;
        else begin
            counter <= counter + 32'd1;
            
            if(counter>=(divisor - 1))
                counter <= 32'd0;
            
            clk_out <= (counter < divisor / 2) ? 1'b1:1'b0;
        end
    end
endmodule
