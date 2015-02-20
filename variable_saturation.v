module variable_saturation
       (
           input clk, reset_n,
           input [ 1: 0 ] sel,
           input [ 34: 0 ] ast_sink_data,
           input [ 1: 0 ] ast_sink_error,
           input ast_sink_valid,
           output [ 11: 0 ] ast_source_data,
           output [ 1: 0 ] ast_source_error,
           output ast_source_valid
       );


// Test instantiation of Altera roundsat module
auk_dspip_roundsat_hpfir saturator0
                         (
                             .clk(),
                             .reset_n(),
                             .enable(),
                             .datain(),
                             .dataout(),
                             .valid()
                         );

defparam
    saturator0.IN_WIDTH_g = 35,
    saturator0.REM_LSB_BIT_g = 15,
    saturator0.REM_LSB_TYPE_g = "Truncation",
    saturator0.REM_MSB_BIT_g = 8,
    saturator0.REM_MSB_TYPE_g = "Saturating";

endmodule
