/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module PaddleLeftObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_diffX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sh8; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:19]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 33:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == 11'sh1e0 ? $signed(11'sh0) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:42 31:16 33:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 37:26]
  wire [10:0] diffX = 11'sh20 - $signed(io_pos_0); // @[\\src\\main\\scala\\vga\\PaddleLeftObj.scala 4:20]
  wire  inXBound = $signed(diffX) >= 11'sh0 & $signed(diffX) <= 11'sh10; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:33]
  wire [10:0] Bottom = $signed(curPosY) + 11'sh64; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 49:24]
  wire  inYBound = $signed(io_pos_1) >= $signed(curPosY) & $signed(io_pos_1) <= $signed(Bottom); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:37]
  assign io_inbound = inXBound & inYBound; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 53:27]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 56:{26,26}]
  assign io_diffX = 11'sh20 - $signed(io_pos_0); // @[\\src\\main\\scala\\vga\\PaddleLeftObj.scala 4:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if ($signed(newPos) > 11'sh1e0) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:19]
        curPosY <= 11'sh1e0;
      end else if ($signed(newPos) < 11'sh64) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:55]
        curPosY <= 11'sh64;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:16]
      end else if ($signed(curPosY) == 11'sh64) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:39]
        velocity <= 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:16]
      end else begin
        velocity <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  curPosY = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[10:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PaddleRightObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_diffX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sh8; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:19]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 33:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == 11'sh1e0 ? $signed(11'sh0) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:42 31:16 33:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 37:26]
  wire [10:0] diffX = $signed(io_pos_0) - 11'sh260; // @[\\src\\main\\scala\\vga\\PaddleRightObj.scala 4:22]
  wire  inXBound = $signed(diffX) >= 11'sh0 & $signed(diffX) <= 11'sh10; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:33]
  wire [10:0] Bottom = $signed(curPosY) + 11'sh64; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 49:24]
  wire  inYBound = $signed(io_pos_1) >= $signed(curPosY) & $signed(io_pos_1) <= $signed(Bottom); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:37]
  assign io_inbound = inXBound & inYBound; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 53:27]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 56:{26,26}]
  assign io_diffX = $signed(io_pos_0) - 11'sh260; // @[\\src\\main\\scala\\vga\\PaddleRightObj.scala 4:22]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if ($signed(newPos) > 11'sh1e0) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:19]
        curPosY <= 11'sh1e0;
      end else if ($signed(newPos) < 11'sh64) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:55]
        curPosY <= 11'sh64;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:16]
      end else if ($signed(curPosY) == 11'sh64) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:39]
        velocity <= 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:16]
      end else begin
        velocity <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  curPosY = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[10:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BallObj(
  input         clock,
  input         reset,
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [10:0] io_P1Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [10:0] io_P2Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  output        io_outLeftBound, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  output        io_outRightBound // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
  reg [10:0] curPos_0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg [10:0] curPos_1; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg  goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 21:27]
  reg  goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 22:26]
  wire [9:0] _goingDown_T_3 = 10'sh1e0 - 10'sh10; // @[\\src\\main\\scala\\vga\\Ball.scala 27:67]
  wire [10:0] _GEN_11 = {{1{_goingDown_T_3[9]}},_goingDown_T_3}; // @[\\src\\main\\scala\\vga\\Ball.scala 27:58]
  wire  _goingDown_T_5 = $signed(curPos_1) > $signed(_GEN_11) ? 1'h0 : goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 27:47]
  wire [10:0] _GEN_12 = {{5{ballSpeed[5]}},ballSpeed}; // @[\\src\\main\\scala\\vga\\Ball.scala 28:44]
  wire [10:0] _curPos_0_T_2 = $signed(curPos_0) + $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 28:44]
  wire [10:0] _curPos_0_T_5 = $signed(curPos_0) - $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 28:67]
  wire [10:0] _curPos_1_T_2 = $signed(curPos_1) + $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 29:43]
  wire [10:0] _curPos_1_T_5 = $signed(curPos_1) - $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 29:66]
  wire [10:0] P1Top = $signed(io_P1Pos_1) - 11'sh6c; // @[\\src\\main\\scala\\vga\\Ball.scala 34:29]
  wire [10:0] P1Bottom = $signed(io_P1Pos_1) + 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 35:31]
  wire [10:0] P2Top = $signed(io_P2Pos_1) - 11'sh6c; // @[\\src\\main\\scala\\vga\\Ball.scala 39:29]
  wire [10:0] P2Bottom = $signed(io_P2Pos_1) + 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 40:32]
  wire  newSpeed = ballSpeed[1] ^ ballSpeed[0] ^ goingDown ^ goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 42:55]
  wire [5:0] _ballSpeed_T_2 = $signed(ballSpeed) + 6'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 50:30]
  wire  _GEN_0 = goingRight & $signed(curPos_0) < 11'sh270 & $signed(curPos_0) > 11'sh250 & $signed(curPos_1) < $signed(
    P2Bottom) & $signed(curPos_1) > $signed(P2Top) ? 1'h0 : goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 47:130 48:18 21:27]
  wire  _GEN_1 = goingRight & $signed(curPos_0) < 11'sh270 & $signed(curPos_0) > 11'sh250 & $signed(curPos_1) < $signed(
    P2Bottom) & $signed(curPos_1) > $signed(P2Top) ? newSpeed : $signed(curPos_1) < 11'sh0 | _goingDown_T_5; // @[\\src\\main\\scala\\vga\\Ball.scala 47:130 27:15 49:17]
  wire  _GEN_3 = ~goingRight & $signed(curPos_0) < 11'sh20 & $signed(curPos_0) > 11'sh0 & $signed(curPos_1) < $signed(
    P1Bottom) & $signed(curPos_1) > $signed(P1Top) | _GEN_0; // @[\\src\\main\\scala\\vga\\Ball.scala 44:125 45:18]
  wire  _GEN_4 = ~goingRight & $signed(curPos_0) < 11'sh20 & $signed(curPos_0) > 11'sh0 & $signed(curPos_1) < $signed(
    P1Bottom) & $signed(curPos_1) > $signed(P1Top) ? newSpeed : _GEN_1; // @[\\src\\main\\scala\\vga\\Ball.scala 44:125 46:17]
  wire  _GEN_6 = io_updateLogic ? _GEN_4 : goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 25:24 22:26]
  wire  _GEN_9 = io_updateLogic ? _GEN_3 : goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 25:24 21:27]
  wire [10:0] _inSquareX_T_3 = $signed(curPos_0) + 11'sh10; // @[\\src\\main\\scala\\vga\\Ball.scala 55:68]
  wire  inSquareX = $signed(io_pos_0) >= $signed(curPos_0) & $signed(io_pos_0) < $signed(_inSquareX_T_3); // @[\\src\\main\\scala\\vga\\Ball.scala 55:43]
  wire [10:0] _inSquareY_T_3 = $signed(curPos_1) + 11'sh10; // @[\\src\\main\\scala\\vga\\Ball.scala 56:68]
  wire  inSquareY = $signed(io_pos_1) >= $signed(curPos_1) & $signed(io_pos_1) < $signed(_inSquareY_T_3); // @[\\src\\main\\scala\\vga\\Ball.scala 56:43]
  assign io_inbound = inSquareX & inSquareY; // @[\\src\\main\\scala\\vga\\Ball.scala 57:28]
  assign io_outLeftBound = $signed(curPos_0) <= 11'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 63:32]
  assign io_outRightBound = $signed(curPos_0) > 11'sh280; // @[\\src\\main\\scala\\vga\\Ball.scala 62:33]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
      ballSpeed <= 6'sh2; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 25:24]
      if (!(~goingRight & $signed(curPos_0) < 11'sh20 & $signed(curPos_0) > 11'sh0 & $signed(curPos_1) < $signed(
        P1Bottom) & $signed(curPos_1) > $signed(P1Top))) begin // @[\\src\\main\\scala\\vga\\Ball.scala 44:125]
        if (goingRight & $signed(curPos_0) < 11'sh270 & $signed(curPos_0) > 11'sh250 & $signed(curPos_1) < $signed(
          P2Bottom) & $signed(curPos_1) > $signed(P2Top)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 47:130]
          ballSpeed <= _ballSpeed_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 50:17]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_0 <= 11'sh140; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 25:24]
      if (goingRight) begin // @[\\src\\main\\scala\\vga\\Ball.scala 28:21]
        curPos_0 <= _curPos_0_T_2;
      end else begin
        curPos_0 <= _curPos_0_T_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_1 <= 11'shf0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 25:24]
      if (goingDown) begin // @[\\src\\main\\scala\\vga\\Ball.scala 29:21]
        curPos_1 <= _curPos_1_T_2;
      end else begin
        curPos_1 <= _curPos_1_T_5;
      end
    end
    goingRight <= reset | _GEN_9; // @[\\src\\main\\scala\\vga\\Ball.scala 21:{27,27}]
    goingDown <= reset | _GEN_6; // @[\\src\\main\\scala\\vga\\Ball.scala 22:{26,26}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ballSpeed = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  curPos_0 = _RAND_1[10:0];
  _RAND_2 = {1{`RANDOM}};
  curPos_1 = _RAND_2[10:0];
  _RAND_3 = {1{`RANDOM}};
  goingRight = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  goingDown = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GraphicsProcessor(
  input         clock,
  output [1:0]  io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
  output [1:0]  io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
  output [1:0]  io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
  input  [10:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
  input  [10:0] io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
  input         io_input1, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
  input         io_input2, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
  input         io_screenDone // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:14]
);
  wire  P1_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire  P1_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire  P1_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire [10:0] P1_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire [10:0] P1_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire  P1_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire [10:0] P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire  P1_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire [10:0] P1_io_diffX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
  wire  P2_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire  P2_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire  P2_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire [10:0] P2_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire [10:0] P2_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire  P2_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire [10:0] P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire  P2_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire [10:0] P2_io_diffX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
  wire  Ball_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire  Ball_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire [10:0] Ball_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire [10:0] Ball_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire  Ball_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire [10:0] Ball_io_P1Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire [10:0] Ball_io_P2Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire  Ball_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire  Ball_io_outLeftBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire  Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
  wire  XOR0 = io_indexX[0] ^ io_indexY[0]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 57:27]
  wire  XOR1 = io_indexX[1] ^ io_indexY[1]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 58:27]
  wire  XOR2 = io_indexX[2] ^ io_indexY[2]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:27]
  wire  XOR3 = io_indexX[3] ^ io_indexY[3]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:27]
  wire  XOR4 = io_indexX[4] ^ io_indexY[4]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 61:27]
  wire  XOR5 = io_indexX[5] ^ io_indexY[5]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:27]
  wire [3:0] BaysianDither = {io_indexY[0],XOR1,io_indexY[1],XOR0}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 65:68]
  wire [10:0] _GEN_4 = P2_io_inbound ? P2_io_diffX : 11'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:30 76:15]
  wire [10:0] inputAbsX = P1_io_inbound ? P1_io_diffX : _GEN_4; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:24 71:15]
  wire [10:0] _GEN_12 = {{7'd0}, BaysianDither}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:28]
  wire  dithered = inputAbsX <= _GEN_12; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:28]
  wire [1:0] _io_col_R_T = {dithered,1'h1}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 72:20]
  wire  _io_col_G_T_1 = XOR4 ^ XOR1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 89:24]
  wire  _io_col_B_T = XOR3 ^ XOR0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 90:24]
  wire  _GEN_1 = Ball_io_inbound ? 1'h0 : XOR5 ^ XOR2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:32 82:14 88:14]
  wire [1:0] _GEN_2 = Ball_io_inbound ? 2'h3 : {{1'd0}, _io_col_G_T_1}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:32 83:14 89:14]
  wire [1:0] _GEN_3 = Ball_io_inbound ? 2'h3 : {{1'd0}, _io_col_B_T}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:32 84:14 90:14]
  wire  _GEN_5 = P2_io_inbound ? 1'h0 : _GEN_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:30 77:14]
  wire [1:0] _GEN_6 = P2_io_inbound ? _io_col_R_T : _GEN_2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:30 78:14]
  wire [1:0] _GEN_7 = P2_io_inbound ? 2'h0 : _GEN_3; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:30 79:14]
  PaddleLeftObj P1 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 35:18]
    .clock(P1_clock),
    .reset(P1_reset),
    .io_input(P1_io_input),
    .io_pos_0(P1_io_pos_0),
    .io_pos_1(P1_io_pos_1),
    .io_inbound(P1_io_inbound),
    .io_paddlePos_1(P1_io_paddlePos_1),
    .io_updateLogic(P1_io_updateLogic),
    .io_diffX(P1_io_diffX)
  );
  PaddleRightObj P2 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:18]
    .clock(P2_clock),
    .reset(P2_reset),
    .io_input(P2_io_input),
    .io_pos_0(P2_io_pos_0),
    .io_pos_1(P2_io_pos_1),
    .io_inbound(P2_io_inbound),
    .io_paddlePos_1(P2_io_paddlePos_1),
    .io_updateLogic(P2_io_updateLogic),
    .io_diffX(P2_io_diffX)
  );
  BallObj Ball ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:20]
    .clock(Ball_clock),
    .reset(Ball_reset),
    .io_pos_0(Ball_io_pos_0),
    .io_pos_1(Ball_io_pos_1),
    .io_inbound(Ball_io_inbound),
    .io_P1Pos_1(Ball_io_P1Pos_1),
    .io_P2Pos_1(Ball_io_P2Pos_1),
    .io_updateLogic(Ball_io_updateLogic),
    .io_outLeftBound(Ball_io_outLeftBound),
    .io_outRightBound(Ball_io_outRightBound)
  );
  assign io_col_R = P1_io_inbound ? _io_col_R_T : {{1'd0}, _GEN_5}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:24 72:14]
  assign io_col_G = P1_io_inbound ? 2'h0 : _GEN_6; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:24 73:14]
  assign io_col_B = P1_io_inbound ? 2'h0 : _GEN_7; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:24 74:14]
  assign P1_clock = clock;
  assign P1_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 52:46]
  assign P1_io_input = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:15]
  assign P1_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:36]
  assign P1_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:53]
  assign P1_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 38:21]
  assign P2_clock = clock;
  assign P2_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 52:46]
  assign P2_io_input = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:15]
  assign P2_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:36]
  assign P2_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:53]
  assign P2_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:21]
  assign Ball_clock = clock;
  assign Ball_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 52:46]
  assign Ball_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:36]
  assign Ball_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:53]
  assign Ball_io_P1Pos_1 = P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:17]
  assign Ball_io_P2Pos_1 = P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 47:17]
  assign Ball_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:23]
endmodule
module GraphicsManager(
  input        clock,
  output [1:0] io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  output [1:0] io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  output [1:0] io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input  [9:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input  [9:0] io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input        io_screenDone, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input        io_input1, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input        io_input2 // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
);
  wire  gpu_clock; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_R; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_G; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_B; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [10:0] gpu_io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [10:0] gpu_io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_input1; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_input2; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  valid = io_indexY < 10'h1e0 & io_indexX < 10'h280; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 42:33]
  GraphicsProcessor gpu ( // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
    .clock(gpu_clock),
    .io_col_R(gpu_io_col_R),
    .io_col_G(gpu_io_col_G),
    .io_col_B(gpu_io_col_B),
    .io_indexX(gpu_io_indexX),
    .io_indexY(gpu_io_indexY),
    .io_input1(gpu_io_input1),
    .io_input2(gpu_io_input2),
    .io_screenDone(gpu_io_screenDone)
  );
  assign io_col_R = valid ? gpu_io_col_R : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 43:18]
  assign io_col_G = valid ? gpu_io_col_G : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 44:18]
  assign io_col_B = valid ? gpu_io_col_B : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 45:18]
  assign gpu_clock = clock;
  assign gpu_io_indexX = {{1'd0}, io_indexX}; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 33:17]
  assign gpu_io_indexY = {{1'd0}, io_indexY}; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 34:17]
  assign gpu_io_input1 = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 36:17]
  assign gpu_io_input2 = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 37:17]
  assign gpu_io_screenDone = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 35:21]
endmodule
module DebouncerModule(
  input   clock,
  input   reset,
  input   io_in, // @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]
  output  io_out // @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  sync0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
  reg  sync1; // @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
  reg  sync2; // @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
  reg [18:0] count; // @[\\src\\main\\scala\\vga\\Debouncer.scala 19:22]
  reg  out; // @[\\src\\main\\scala\\vga\\Debouncer.scala 23:20]
  wire [18:0] _count_T_1 = count + 19'h1; // @[\\src\\main\\scala\\vga\\Debouncer.scala 28:20]
  assign io_out = out; // @[\\src\\main\\scala\\vga\\Debouncer.scala 24:10]
  always @(posedge clock) begin
    sync0 <= io_in; // @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
    sync1 <= sync0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
    sync2 <= sync1; // @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
    if (reset) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 19:22]
      count <= 19'h0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 19:22]
    end else if (sync2 != io_out) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 27:27]
      count <= _count_T_1; // @[\\src\\main\\scala\\vga\\Debouncer.scala 28:11]
    end else begin
      count <= 19'h0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 33:11]
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 23:20]
      out <= 1'h0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 23:20]
    end else if (sync2 != io_out) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 27:27]
      if (count == 19'h7ffff) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 29:31]
        out <= sync2; // @[\\src\\main\\scala\\vga\\Debouncer.scala 30:11]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sync0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sync1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sync2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  count = _RAND_3[18:0];
  _RAND_4 = {1{`RANDOM}};
  out = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module VGAModule(
  input        clock,
  input        reset,
  output [1:0] io_col_R, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output [1:0] io_col_G, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output [1:0] io_col_B, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output       io_hsync, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output       io_vsync, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  input        io_input1, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  input        io_input2 // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  graphics_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [1:0] graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [1:0] graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [1:0] graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [9:0] graphics_io_indexX; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [9:0] graphics_io_indexY; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire  graphics_io_screenDone; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire  graphics_io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire  graphics_io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire  debouncer1_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:26]
  wire  debouncer1_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:26]
  wire  debouncer1_io_in; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:26]
  wire  debouncer1_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:26]
  wire  debouncer2_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:26]
  wire  debouncer2_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:26]
  wire  debouncer2_io_in; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:26]
  wire  debouncer2_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:26]
  reg [9:0] hCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap = hCounter == 10'h31f; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_1 = hCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  reg [9:0] vCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap_1 = vCounter == 10'h20c; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_3 = vCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  GraphicsManager graphics ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
    .clock(graphics_clock),
    .io_col_R(graphics_io_col_R),
    .io_col_G(graphics_io_col_G),
    .io_col_B(graphics_io_col_B),
    .io_indexX(graphics_io_indexX),
    .io_indexY(graphics_io_indexY),
    .io_screenDone(graphics_io_screenDone),
    .io_input1(graphics_io_input1),
    .io_input2(graphics_io_input2)
  );
  DebouncerModule debouncer1 ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:26]
    .clock(debouncer1_clock),
    .reset(debouncer1_reset),
    .io_in(debouncer1_io_in),
    .io_out(debouncer1_io_out)
  );
  DebouncerModule debouncer2 ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:26]
    .clock(debouncer2_clock),
    .reset(debouncer2_reset),
    .io_in(debouncer2_io_in),
    .io_out(debouncer2_io_out)
  );
  assign io_col_R = graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 44:12]
  assign io_col_G = graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 45:12]
  assign io_col_B = graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 46:12]
  assign io_hsync = hCounter > 10'h28f & hCounter < 10'h2f0 ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 49:18]
  assign io_vsync = vCounter > 10'h1e9 & vCounter < 10'h1ec ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 50:18]
  assign graphics_clock = clock;
  assign graphics_io_indexX = hCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 32:22]
  assign graphics_io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:22]
  assign graphics_io_screenDone = wrap_wrap & wrap_wrap_1; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  assign graphics_io_input1 = debouncer1_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 42:22]
  assign graphics_io_input2 = debouncer2_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 43:22]
  assign debouncer1_clock = clock;
  assign debouncer1_reset = reset;
  assign debouncer1_io_in = io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 37:20]
  assign debouncer2_clock = clock;
  assign debouncer2_reset = reset;
  assign debouncer2_io_in = io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 40:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      hCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (wrap_wrap) begin // @[src/main/scala/chisel3/util/Counter.scala 87:20]
      hCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 87:28]
    end else begin
      hCounter <= _wrap_value_T_1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      vCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (wrap_wrap) begin // @[src/main/scala/chisel3/util/Counter.scala 118:16]
      if (wrap_wrap_1) begin // @[src/main/scala/chisel3/util/Counter.scala 87:20]
        vCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 87:28]
      end else begin
        vCounter <= _wrap_value_T_3; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  hCounter = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  vCounter = _RAND_1[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule



module tt_um_pong (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

    VGAModule VGA (
        .clock(clk),
         .reset(~rst_n),
        .io_col_R({uo_out[4], uo_out[0]}),
        .io_col_G({uo_out[5], uo_out[1]}),
        .io_col_B({uo_out[6], uo_out[2]}),
        .io_hsync(uo_out[7]),
        .io_vsync(uo_out[3]),
        .io_input1(ui_in[0]),
        .io_input2(ui_in[1])
    
    );

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:2], uio_in[7:0], clk, rst_n, 1'b0};

endmodule
