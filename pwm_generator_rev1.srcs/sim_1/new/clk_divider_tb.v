`timescale 1ns/1ps

module clk_divider_tb;

    reg clk;
    reg rst;
    
    wire clk_out;


    clk_divider uut (
        .clk_in(clk),
        .clk_out(clk_out),
        .rst(rst)
    );
    
    // clock gen
    parameter clk_period = 10;
    initial begin
        clk = 0;
    end
    always #(clk_period / 2) clk = ~clk;


    initial begin
        rst = 1;
        delay(2);
        rst = 0;
        delay(50);
        
        $finish;
    end

// tasks
task delay (input integer delay_rate);
    #(delay_rate * clk_period);
endtask

endmodule
