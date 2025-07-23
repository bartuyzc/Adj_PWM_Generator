module pwm_generator (
    input clk,
    input rst,
    input inc_duty,
    input dec_duty,
    input inc_freq,
    input dec_freq,
    input mode_select,
    output reg pwm_out
);

    // look-up-table for frequency steps
    reg [7:0] freq_table [0:19];
    reg [4:0] freq_index = 4'd0;

    initial begin
        freq_table[0] = 247;
        freq_table[1] = 125;
        freq_table[2] = 83;
        freq_table[3] = 60;
        freq_table[4] = 49;
        freq_table[5] = 40;
        freq_table[6] = 35;
        freq_table[7] = 30;
        freq_table[8] = 27;
        freq_table[9] = 24;
        freq_table[10] = 21;
        freq_table[11] = 20;
        freq_table[12] = 18;
        freq_table[13] = 17;
        freq_table[14] = 16;
        freq_table[15] = 15;
        freq_table[16] = 14;
        freq_table[17] = 13;
        freq_table[18] = 12;
        freq_table[19] = 11;
    end

    reg [7:0] count = 8'd0;
    reg [7:0] period;
    reg [7:0] active = 8'd0;
    reg [7:0] duty_percentage = 8'd50;
    reg [7:0] duty_step = 8'd5;
    reg dir = 1'b1;
    
    
    // first values
    initial begin
        period = freq_table[0];
        active = (freq_table[0] * duty_percentage) / 100;
    end

    // adjusting duty time
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            duty_percentage <= 8'd50;
        end 
        else begin
            if (inc_duty && duty_percentage + duty_step <= 100) begin
                duty_percentage <= duty_percentage + duty_step;
            end else if (dec_duty && duty_percentage >= duty_step) begin
                duty_percentage <= duty_percentage - duty_step;
            end
        end
    end

    // adjusting freq
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            freq_index <= 4'd0;
            period <= freq_table[0];
        end else begin
            if (inc_freq && freq_index < 19) begin
                freq_index <= freq_index + 1;
                period <= freq_table[freq_index + 1];
            end else if (dec_freq && freq_index > 0) begin
                freq_index <= freq_index - 1;
                period <= freq_table[freq_index - 1];
            end
        end
    end

    // setting active duration
    always @(*) begin
        active = (period * duty_percentage) / 100;
    end

    // pwm counter depending on center-aligned or edge-aligned
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            dir <= 1;
        end else begin
            if (mode_select) begin
                // center-aligned counter depending on dir to count up and down 
                if (dir) begin
                    if (count >= (period >> 1)) begin
                        dir <= 0;
                        count <= count - 1;
                    end 
                    else begin
                        count <= count + 1;
                    end
                end 
                else begin
                    if (count == 0) begin
                        dir <= 1;
                        count <= count + 1;
                    end 
                    else begin
                        count <= count - 1;
                    end
                end
            end 
            else begin
            // the usual counter for edge-aligned
                if (count >= period) begin
                    count <= 0;
                end 
                else begin
                    count <= count + 1;
                end
            end
        end
    end

    // pwm output
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pwm_out <= 0;
        end else begin
            if (mode_select) begin
                // center-aligned's output
                pwm_out <= (count < (active >> 1)) ? 1'b1 : 1'b0;
            end else begin
                // edge aligned's output
                pwm_out <= (count < active) ? 1'b1 : 1'b0;
            end
        end
    end

endmodule
