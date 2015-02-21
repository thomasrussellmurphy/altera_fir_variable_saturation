# altera_fir_variable_saturation
An implementation of a 4-bank gain select for reducing a 35-bit signed Avalon ST data stream to a 12-bit signed Avalon ST data stream using a combination of MSB saturation and LSB truncation. This implementation delays the data on the Avalon ST bus by one clock cycle.

For CWRU EECS 301 Lab 4, Spring 2015. This block will immediately follow the FIR Compiler II instance in the Avalon ST signal chain. Bit counts for saturation and truncation are chosen to approximately equalize the gain of the four filter banks used in this lab.

The included (c) Altera VHDL file is a component of the FIR Compiler II and should not need to be included in a Quartus II project that already contains a configured FIR MegaFunction instance.
