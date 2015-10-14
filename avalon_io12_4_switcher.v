module avalon_io12_4_switcher( clk, select,
                               sink_data_0, sink_valid_0, sink_error_0,
                               sink_data_1, sink_valid_1, sink_error_1,
                               sink_data_2, sink_valid_2, sink_error_2,
                               sink_data_3, sink_valid_3, sink_error_3,
                               source_data, source_valid, source_error );

input wire clk;
input wire [ 1: 0 ] select;

input wire [ 11: 0 ] sink_data_0, sink_data_1, sink_data_2, sink_data_3;
input wire sink_valid_0, sink_valid_1, sink_valid_2, sink_valid_3;
input wire [ 1: 0 ] sink_error_0, sink_error_1, sink_error_2, sink_error_3;

output reg [ 11: 0 ] source_data;
output reg source_valid;
output reg [ 1: 0 ] source_error;

// Mux between the four input Avalon data sinks
always @( posedge clk ) begin
    case ( select )
        2'b00 : begin
            source_data <= sink_data_0;
            source_valid <= sink_valid_0;
            source_error <= sink_error_0;
        end
        2'b01 : begin
            source_data <= sink_data_1;
            source_valid <= sink_valid_1;
            source_error <= sink_error_1;
        end
        2'b10 : begin
            source_data <= sink_data_2;
            source_valid <= sink_valid_2;
            source_error <= sink_error_2;
        end
        2'b11 : begin
            source_data <= sink_data_3;
            source_valid <= sink_valid_3;
            source_error <= sink_error_3;
        end
        default: begin
            source_data <= sink_data_0;
            source_valid <= sink_valid_0;
            source_error <= sink_error_0;
        end
    endcase
end

endmodule
