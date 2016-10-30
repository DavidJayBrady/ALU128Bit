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
                                    
    logic cout127;

    ALU1B FirstALU (
                        .a(op1[0]),
                        .b(op2[0]),
                        .opsel(opsel),
                        .mode(mode),
                        .cin(firstCin),
                        .cout(Couts[0]),
                        .result(result[0])
                     );
    generate
    genvar i;
        for (i=1; i < DWIDTH; i++) begin: creation

            ALU1B OtherALUs   (
                              .a(op1[i]),
                              .b(op2[i]),
                              .opsel(opsel),
                              .mode(mode),
                              .cin(Couts[i-1]),
                              .cout(Couts[i]),
                              .result(result[i])
                            );
           assign couts127 = (i == 127)? Couts[i]:
                                            0;
                                              
        end
    endgenerate
        
    assign s_flag = result[127];
    assign z_flag = ~(|result);
    assign c_flag = cout127;
    assign o_flag = (op1[127] == op2[127] & result[127] != op1[127])? 1:
                                                                0;
    
    
endmodule 
