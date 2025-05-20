module synchronizer (input clk_i,
                     input rst_i,
                     input [3:0] grey_i,
                     output logic [3:0] grey_sync_o);
    
    logic [3:0] grey_delay;

    always_ff @ (posedge clk_i, negedge rst_i)
    begin
        if (~rst_i)
        begin
            grey_delay <=  'b0;
            grey_sync_o <= 'b0;
        end

        else 
        begin
            grey_delay <= grey_i;
            grey_sync_o <= grey_delay;
        end
    end
endmodule