`timescale 1ns / 1ps

module top(
        input clk,
        input rst,
        input inc_duty,
        input dec_duty,
        input inc_freq,
        input dec_freq,
        input mode_select,
        output pwm_out
    );
    
    wire temp1, temp2, temp3, temp4;
    
    pwm_generator pwm_generator_inst (
        .clk(clk),
        .rst(rst),
        .inc_duty(temp1),
        .dec_duty(temp2),
        .inc_freq(temp3),
        .dec_freq(temp4),
        .mode_select(mode_select),
        .pwm_out(pwm_out)
    );
    
   
    debouncing_filter debouncing_filter_inst1 (
        .clk(clk),
        .rst(rst),
        .filter_in(inc_duty),
        .filter_out(temp1)
    ); 
    debouncing_filter debouncing_filter_inst2 (
        .clk(clk),
        .rst(rst),
        .filter_in(dec_duty),
        .filter_out(temp2)
    ); 
    debouncing_filter debouncing_filter_inst3 (
        .clk(clk),
        .rst(rst),
        .filter_in(inc_freq),
        .filter_out(temp3)
    ); 
    debouncing_filter debouncing_filter_inst4 (
        .clk(clk),
        .rst(rst),
        .filter_in(dec_freq),
        .filter_out(temp4)
    ); 
    
endmodule
