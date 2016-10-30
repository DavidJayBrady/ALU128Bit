`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2016 08:59:05 PM
// Design Name: 
// Module Name: ALU128B
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU128B ( op1 , op2 , opsel , mode , result , c_flag , z_flag , o_flag , s_flag );

    parameter DWIDTH = 128;

    input  logic [ DWIDTH -1:0] op1 ;
    input  logic [ DWIDTH -1:0] op2 ;
    input  logic [ 2:0]         opsel ;
    input  logic                mode ;
    output logic [ DWIDTH -1:0] result ;
    output logic                c_flag ;
    output logic                z_flag ;
    output logic                o_flag ;
    output logic                s_flag ;

    logic firstCout;

    logic cin;
    assign cin = (opsel == 3'b100)? 1:
                 (opsel == 3'b110)? 1:
                 // when else should cin be one?
                                    0;

    ALU1B FirstALU (
                        .a(op1),
                        .b(op2),
                        .opsel(opsel),
                        .mode(mode),
                        .cin(cin),
                        .cout(firstCout),
                        .result(result[0])
                     );

//    genvar i;
//    generate
//        for (i=0; i < DWIDTH; i++) begin: creation
            
//        end
//    endgenerate
    

endmodule ;
