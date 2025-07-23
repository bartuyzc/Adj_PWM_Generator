module debouncing_filter(
    input filter_in,
    input rst,
    input clk,
    output filter_out
    );
    
    wire slow_clk;
    wire temp_Q;
    wire temp_not_Q;
    
    dff dff_inst1 (
        .clk(slow_clk),
        .rst(rst),
        .D(filter_in),
        .Q(temp_Q),
        .not_Q()
    );
    
    dff dff_inst2 (
        .clk(slow_clk),
        .rst(rst),
        .D(temp_Q),
        .Q(),
        .not_Q(temp_not_Q)
    );    
    
    clk_divider clk_divider_inst (
        .clk_in(clk),
        .rst(rst),
        .clk_out(slow_clk)
    );
    
//    always @(posedge clk or posedge rst) begin 
//        if (rst)
//            filter_out <= 0;
//        else 
//            filter_out <= temp_not_Q && temp_Q;
//    end    

    assign filter_out = temp_not_Q && temp_Q;
endmodule
