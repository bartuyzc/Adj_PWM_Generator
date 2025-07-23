`timescale 1ns/1ps

module pwm_generator_freq_tb;

    reg clk;
    reg rst;
    reg inc_duty = 0;
    reg dec_duty = 0;
    reg inc_freq = 0;
    reg dec_freq = 0;
    reg mode_select;
    wire pwm_out;

    pwm_generator uut (
        .clk(clk),
        .rst(rst),
        .inc_duty(inc_duty),
        .dec_duty(dec_duty),
        .inc_freq(inc_freq),
        .dec_freq(dec_freq),
        .mode_select(mode_select),
        .pwm_out(pwm_out)
    );
    
    // clock gen
    parameter clk_period = 40;
    initial begin
        clk = 0;
    end
    always #(clk_period / 2) clk = ~clk;


    initial begin
        mode_select = 0;
        reset(2);   // 1
        delay(500);
        up_freq();  // 2
        delay(250);
        up_freq();  // 3
        delay(250);
        up_freq();  // 4
        delay(250);
        up_freq();  // 5
        delay(250);
        up_freq();  // 6
        delay(250);
        up_freq();  // 7
        delay(250);
        up_freq();  // 8
        delay(250);
        up_freq();  // 9
        delay(250);                    
        up_freq();  // 10
        delay(250);
        up_freq();  // 11
        delay(250);
        up_freq();  // 12
        delay(250);
        up_freq();  // 13
        delay(250);                    
        up_freq();  // 14
        delay(250);
        up_freq();  // 15
        delay(250);
        up_freq();  // 16
        delay(250);                    
        up_freq();  // 17
        delay(250);
        up_freq();  // 18
        delay(250);
        up_freq();  // 19
        delay(250);
        up_freq();  // 20
        delay(250);
          
        down_freq();
        delay(250);

        down_freq();
        delay(250);        
          
        down_freq();
        delay(250);          
          
        down_freq();
        delay(250);
                    
          $finish;
    end

// Tasks
task delay (input integer delay_rate);
    #(delay_rate * clk_period);
endtask

task up_duty();
    begin
        inc_duty = 1;
        #(clk_period)
        inc_duty = 0;
    end
endtask 

task down_duty();
    begin
        dec_duty = 1;
        #(clk_period)
        dec_duty = 0;
    end
endtask 

task up_freq();
    begin
        inc_freq = 1;
        #(clk_period)
        inc_freq = 0;
    end
endtask

task down_freq();
    begin
        dec_freq = 1;
        #(clk_period)
        dec_freq = 0;
    end
endtask

task reset (input integer reset_time);
    begin
        rst = 1;
        #(clk_period * reset_time)
        rst = 0;
    end
endtask


endmodule
