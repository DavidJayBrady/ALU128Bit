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

    logic [ DWIDTH - 1:0] Couts;

    logic firstCin;
    assign firstCin = (opsel == 3'b011)? 1:
                 (opsel == 3'b100)? 1:
                 (opsel == 3'b110)? 1:
                 // when else should cin be one?
                                    0;

    ALU1B FirstALU (
                        .a(op1[0]),
                        .b(op2[0]),
                        .opsel(opsel),
                        .mode(mode),
                        .cin(firstCin),
                        .cout(Couts[0]),
                        .result(result[0])
                     );

    logic tempCarryInIndex;

    generate
    genvar i;
        for (i=1; i < DWIDTH; i++) begin: creation

            assign tempCarryInIndex = i-1;

            ALU1B OtherALUs   (
                              .a(op1[i]),
                              .b(op2[i]),
                              .opsel(opsel),
                              .mode(mode),
                              .cin(Couts[tempCarryInIndex]),
                              .cout(Couts[i]),
                              .result(result[i])
                            );
        end
    endgenerate
    
    // lastCout = Couts[127] .. or is it 0? or 1?
    
    assign s_flag = Couts[127];
    // sign flag found by taking the result[0] or result[127]
    
    
endmodule 
