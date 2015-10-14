module avalon_io12_4_switcher
       (
         input clk,
         input [ 1: 0 ] select,
         input [ 11: 0 ] sink_data_0, sink_data_1, sink_data_2, sink_data_3,
         input sink_valid_0, sink_valid_1, sink_valid_2, sink_valid_3,
         input [ 1: 0 ] sink_error_0, sink_error_1, sink_error_2, sink_error_3,

         output [ 11: 0 ] source_data,
         output source_valid,
         output [ 1: 0 ] source_error
       );

reg [ 11: 0 ] source_data_reg;
reg source_valid_reg;
reg [ 1: 0 ] source_error_reg;

assign source_data = source_data_reg;
assign source_valid = source_valid_reg;
assign source_error = source_error_reg;

// Mux between the four input Avalon data sinks
always @( posedge clk ) begin
  case ( select )
    2'b00 :
    begin
      source_data_reg <= sink_data_0;
      source_valid_reg <= sink_valid_0;
      source_error_reg <= sink_error_0;
    end
    2'b01 :
    begin
      source_data_reg <= sink_data_1;
      source_valid_reg <= sink_valid_1;
      source_error_reg <= sink_error_1;
    end
    2'b10 :
    begin
      source_data_reg <= sink_data_2;
      source_valid_reg <= sink_valid_2;
      source_error_reg <= sink_error_2;
    end
    2'b11 :
    begin
      source_data_reg <= sink_data_3;
      source_valid_reg <= sink_valid_3;
      source_error_reg <= sink_error_3;
    end
    default:
    begin
      source_data_reg <= sink_data_0;
      source_valid_reg <= sink_valid_0;
      source_error_reg <= sink_error_0;
    end
  endcase
end

endmodule
