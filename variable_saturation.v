module variable_saturation
       (
           input clk, reset_n,
           input [ 1: 0 ] sel,
           input [ 34: 0 ] ast_sink_data,
           input [ 1: 0 ] ast_sink_error,
           input ast_sink_valid,
           output reg [ 11: 0 ] ast_source_data,
           output reg [ 1: 0 ] ast_source_error,
           output reg ast_source_valid
       );

// Different versions of the processed data
wire [ 11: 0 ] saturator_data0, saturator_data1, saturator_data2, saturator_data3;
wire saturator_valid0, saturator_valid1, saturator_valid2, saturator_valid3;

// Propagate the error with 1 cycle pipelined, like the roundsat
always @( posedge clk ) ast_source_error <= ast_sink_error;

always @( * ) begin
    case ( sel )
        0: begin
            ast_source_data <= saturator_data0;
            ast_source_valid <= saturator_valid0;
        end
        1: begin
            ast_source_data <= saturator_data1;
            ast_source_valid <= saturator_valid1;
        end
        2: begin
            ast_source_data <= saturator_data2;
            ast_source_valid <= saturator_valid2;
        end
        3: begin
            ast_source_data <= saturator_data3;
            ast_source_valid <= saturator_valid3;
        end
        default: begin
            ast_source_data <= saturator_data0;
            ast_source_valid <= saturator_valid0;
        end
    endcase
end

// Instantiate the 4 saturator instances with the appropriate parameters
// Each saturator is 35-bit to 12-bit
// Expected order of filters: flat, low pass, band pass, high pass

auk_dspip_roundsat_hpfir saturator0
                         (
                             .clk( clk ),
                             .reset_n( reset_n ),
                             .enable( ast_sink_valid ),
                             .datain( ast_sink_data ),
                             .dataout( saturator_data0 ),
                             .valid( saturator_valid0 )
                         );

defparam
    saturator0.IN_WIDTH_g = 35,
    saturator0.REM_LSB_BIT_g = 15,
    saturator0.REM_LSB_TYPE_g = "Truncation",
    saturator0.REM_MSB_BIT_g = 8,
    saturator0.REM_MSB_TYPE_g = "Saturating";

auk_dspip_roundsat_hpfir saturator1
                         (
                             .clk( clk ),
                             .reset_n( reset_n ),
                             .enable( ast_sink_valid ),
                             .datain( ast_sink_data ),
                             .dataout( saturator_data1 ),
                             .valid( saturator_valid1 )
                         );

defparam
    saturator1.IN_WIDTH_g = 35,
    saturator1.REM_LSB_BIT_g = 20,
    saturator1.REM_LSB_TYPE_g = "Truncation",
    saturator1.REM_MSB_BIT_g = 3,
    saturator1.REM_MSB_TYPE_g = "Saturating";

auk_dspip_roundsat_hpfir saturator2
                         (
                             .clk( clk ),
                             .reset_n( reset_n ),
                             .enable( ast_sink_valid ),
                             .datain( ast_sink_data ),
                             .dataout( saturator_data2 ),
                             .valid( saturator_valid2 )
                         );

defparam
    saturator2.IN_WIDTH_g = 35,
    saturator2.REM_LSB_BIT_g = 19,
    saturator2.REM_LSB_TYPE_g = "Truncation",
    saturator2.REM_MSB_BIT_g = 4,
    saturator2.REM_MSB_TYPE_g = "Saturating";


auk_dspip_roundsat_hpfir saturator3
                         (
                             .clk( clk ),
                             .reset_n( reset_n ),
                             .enable( ast_sink_valid ),
                             .datain( ast_sink_data ),
                             .dataout( saturator_data3 ),
                             .valid( saturator_valid3 )
                         );

defparam
    saturator3.IN_WIDTH_g = 35,
    saturator3.REM_LSB_BIT_g = 16,
    saturator3.REM_LSB_TYPE_g = "Truncation",
    saturator3.REM_MSB_BIT_g = 7,
    saturator3.REM_MSB_TYPE_g = "Saturating";
endmodule
