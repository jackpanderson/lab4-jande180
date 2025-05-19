module synchronizer (input clk_r_i,
                     input clk_w_i,
                     input rst_i,
                     input [3:0] grey_w_i,
                     input [3:0] grey_r_i,
                     output logic [3:0] grey_w_sync_o,
                     output logic [3:0] grey_r_sync_o);
    
    logic [3:0] grey_w_delay, grey_r_delay;

    always_ff @ (posedge clk_w_i, negedge rst_i)
    begin
        if (~rst_i)
        begin
            grey_w_delay <=  'b0;
            grey_w_sync_o <= 'b0;
        end

        else 
        begin
            grey_w_delay <= grey_w_i;
            grey_w_sync_o <= grey_w_delay;
        end
    end

    always_ff @ (posedge clk_r_i, negedge rst_i)
    begin
        if (~rst_i)
        begin
            grey_r_delay <=  'b0;
            grey_r_sync_o <= 'b0;
        end

        else 
        begin
            grey_r_delay <= grey_r_i;
            grey_r_sync_o <= grey_r_delay;
        end
    end
    
endmodule