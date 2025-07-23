`timescale 1ns / 1ps

module debouncing_filter_tb();

    reg filter_in;
    reg clk;
    reg rst;

    wire filter_out;

    debouncing_filter uut (
        .filter_in(filter_in), 
        .clk(clk), 
        .rst(rst),
        .filter_out(filter_out)
    );
    
    // clock gen
    parameter clk_period = 10;
    initial clk = 0;
    always #(clk_period / 2) clk = ~clk;
    
    initial begin
        filter_in = 0;
        reset(2);

        filter_in = 1; delay(1);
        filter_in = 0; delay(1);
        filter_in = 1; delay(2);
        filter_in = 0; delay(1);
        filter_in = 1; delay(3);

        delay(50);

        filter_in = 0; delay(1);
        filter_in = 1; delay(1);
        filter_in = 0; delay(2);
        filter_in = 1; delay(1);
        filter_in = 0; delay(3);

        delay(50);

        filter_in = 1; delay(1);
        filter_in = 0; delay(1);
        filter_in = 1; delay(2);
        filter_in = 0; delay(1);
        filter_in = 1; delay(1);
        filter_in = 0; delay(1);

        delay(50);

        filter_in = 1; delay(80);
        filter_in = 0; delay(80);

        delay(50);

        filter_in = 1; delay(2);
        filter_in = 0; delay(1);
        filter_in = 1; delay(3);
        filter_in = 0; delay(2);
        filter_in = 1; delay(2);
        filter_in = 0; delay(3);

        delay(50);

        filter_in = 1; delay(1);
        filter_in = 0; delay(1);
        filter_in = 1; delay(1);
        filter_in = 0; delay(1);
        filter_in = 1; delay(1);
        filter_in = 0; delay(1);
        filter_in = 1; delay(1);
        filter_in = 0; delay(1);
        filter_in = 1; delay(10); 

        delay(50);

        filter_in = 0; delay(100);

        $finish;
    end 

    // Tasks
    task delay (input integer delay_rate);
        #(delay_rate * clk_period);
    endtask
    
    task reset (input integer reset_time);
        begin
            rst = 1;
            #(clk_period * reset_time)
            rst = 0;
        end
    endtask

endmodule
