`timescale 1ns/1ps

module dff_tb;

    reg clk;
    reg rst;
    reg D;
    
    wire Q;
    wire not_Q;


    dff uut (
        .clk(clk),
        .rst(rst),
        .D(D),
        .Q(Q),
        .not_Q(not_Q)
    );
    
    // clock gen
    parameter clk_period = 10;
    initial begin
        clk = 0;
    end
    always #(clk_period / 2) clk = ~clk;


    initial begin
        rst = 1;
        D = 1;        
        delay(1); 
        rst = 0;
        delay(3);
        D = 0;
        delay(3);
        
        $finish;
    end

// tasks
task delay (input integer delay_rate);
    #(delay_rate * clk_period);
endtask

endmodule
