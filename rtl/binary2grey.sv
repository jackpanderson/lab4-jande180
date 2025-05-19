module binary2grey #(parameter N=4) ( input  [N-1:0] bin,
                                   output [N-1:0] gray);

  assign gray = bin ^ (bin >> 1);

endmodule