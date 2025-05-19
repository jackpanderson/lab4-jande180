module async_fifo # (parameter WIDTH = 32) 
                
                  (input clk_r_i,
                   input clk_w_i,
                   input rsi_i, //Active LOW async reset
                   input [WIDTH -1:0] i_wdata,
                   input i_wenable,
                   input i_renable,
                   
                   output logic [WIDTH-1:0] o_rdata,
                   output logic o_empty,
                   output logic o_full)

    logic [WIDTH - 1:0] mem [7:0]; //8x32bit, need 3 + 1 bit w/r pointers
    logic [2 + 1:0] w_ptr, r_ptr, w_ptr_grey, r_ptr_grey, r_ptr_grey_sync, w_ptr_grey_sync; //MAKE SYNCED !!!!!

    binary2grey b2g_w (.bin(w_ptr), .grey(w_ptr_grey)); //Binary to grey encoders for read and write pointers
    binary2grey b2g_r (.bin(r_ptr), .grey(r_ptr_grey));

    synchronizer synchro (.clk_r_i(clk_r_i), .clk_w_i(clk_w_i), .rst_i(rst_i),
                          .grey_w_i(w_ptr_grey), .grey_r_i(r_ptr_grey),
                          .grey_w_sync_o(w_ptr_grey_sync), .grey_r_sync_o(r_ptr_grey_sync));
    

    assign o_empty = w_ptr_grey_sync == r_ptr_grey;
    assign o_full = (w_ptr_grey[3] == ~r_ptr_grey_sync[3]) && (w_ptr_grey[2:0] == r_ptr_grey_sync[2:0]); //mayhbe? check this

    always_ff @ (posedge clk_w_i, negedge rst_i)
    begin
        if (!rst_i)
        begin
            mem[0] <= 'b0;
            mem[1] <= 'b0;
            mem[2] <= 'b0;
            mem[3] <= 'b0;
            mem[4] <= 'b0;
            mem[5] <= 'b0;
            mem[6] <= 'b0;
            mem[7] <= 'b0;
        end
    end
    
    always_ff @ (posedge clk_r_i, negedge rst_i)
    begin
        if (!rst_i)
        begin
            mem[0] <= 'b0;
            mem[1] <= 'b0;
            mem[2] <= 'b0;
            mem[3] <= 'b0;
            mem[4] <= 'b0;
            mem[5] <= 'b0;
            mem[6] <= 'b0;
            mem[7] <= 'b0;
        end
    end

    




endmodule