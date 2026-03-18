/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module PaddleObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_sideX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
  wire [9:0] bottomWall = 10'sh1e0 - 10'sh40; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 21:27]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sh8; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:19]
  wire [10:0] _GEN_5 = {{1{bottomWall[9]}},bottomWall}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:26]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 33:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == 11'sh40 ? $signed(11'sh1) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:39 31:16 33:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 37:26]
  wire [10:0] diffX = $signed(io_pos_0) - 11'sh40; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 41:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] _absY_T_2 = $signed(io_pos_1) - $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:25]
  wire [10:0] _absY_T_6 = 11'sh0 - $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  wire [10:0] absY = $signed(_absY_T_2) < 11'sh0 ? $signed(_absY_T_6) : $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  assign io_inbound = $signed(absX) < 11'sh8 & $signed(absY) < 11'sh40; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:54]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:{26,26}]
  assign io_sideX = diffX[10]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 49:25]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if ($signed(newPos) > $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:19]
        curPosY <= {{1{bottomWall[9]}},bottomWall};
      end else if ($signed(newPos) < 11'sh40) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:55]
        curPosY <= 11'sh40;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:16]
      end else if ($signed(curPosY) == $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:42]
        velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:16]
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
module PaddleObj_1(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_sideX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
  wire [9:0] bottomWall = 10'sh1e0 - 10'sh40; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 21:27]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sh8; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:19]
  wire [10:0] _GEN_5 = {{1{bottomWall[9]}},bottomWall}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:26]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 33:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == 11'sh40 ? $signed(11'sh1) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:39 31:16 33:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 37:26]
  wire [10:0] diffX = $signed(io_pos_0) - 11'sh240; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 41:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] _absY_T_2 = $signed(io_pos_1) - $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:25]
  wire [10:0] _absY_T_6 = 11'sh0 - $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  wire [10:0] absY = $signed(_absY_T_2) < 11'sh0 ? $signed(_absY_T_6) : $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  assign io_inbound = $signed(absX) < 11'sh8 & $signed(absY) < 11'sh40; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:54]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:{26,26}]
  assign io_sideX = diffX[10]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 49:25]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if ($signed(newPos) > $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:19]
        curPosY <= {{1{bottomWall[9]}},bottomWall};
      end else if ($signed(newPos) < 11'sh40) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:55]
        curPosY <= 11'sh40;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:16]
      end else if ($signed(curPosY) == $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:42]
        velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:16]
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
  reg [10:0] ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
  reg [10:0] curPos_0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg [10:0] curPos_1; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg [10:0] velocity_0; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
  reg [10:0] velocity_1; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
  wire [9:0] _velocity_1_T_3 = 10'sh1e0 - 10'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 26:97]
  wire [10:0] _GEN_11 = {{1{_velocity_1_T_3[9]}},_velocity_1_T_3}; // @[\\src\\main\\scala\\vga\\Ball.scala 26:88]
  wire [10:0] _velocity_1_T_7 = 11'sh0 - $signed(ballSpeed); // @[\\src\\main\\scala\\vga\\Ball.scala 26:127]
  wire [10:0] _velocity_1_T_8 = $signed(curPos_1) > $signed(_GEN_11) ? $signed(_velocity_1_T_7) : $signed(velocity_1); // @[\\src\\main\\scala\\vga\\Ball.scala 26:77]
  wire [10:0] _velocity_1_T_9 = $signed(curPos_1) < 11'sh8 ? $signed(ballSpeed) : $signed(_velocity_1_T_8); // @[\\src\\main\\scala\\vga\\Ball.scala 26:23]
  wire [10:0] _curPos_0_T_2 = $signed(curPos_0) + $signed(velocity_0); // @[\\src\\main\\scala\\vga\\Ball.scala 27:28]
  wire [10:0] _curPos_1_T_2 = $signed(curPos_1) + $signed(velocity_1); // @[\\src\\main\\scala\\vga\\Ball.scala 28:28]
  wire [10:0] newYSpeed = velocity_1[0] ^ velocity_0[1] ? $signed(ballSpeed) : $signed(_velocity_1_T_7); // @[\\src\\main\\scala\\vga\\Ball.scala 30:24]
  wire  goingLeft = $signed(velocity_0) < 11'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 33:33]
  wire [10:0] _P1xOverlap_T_2 = 11'sh40 - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 34:47]
  wire [10:0] _P1xOverlap_T_5 = $signed(_P1xOverlap_T_2) - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 34:76]
  wire  P1xOverlap = $signed(curPos_0) > $signed(_P1xOverlap_T_5) & $signed(curPos_0) < 11'sh50; // @[\\src\\main\\scala\\vga\\Ball.scala 34:105]
  wire [10:0] _P1yOverlap_T_2 = $signed(io_P1Pos_1) - 11'sh40; // @[\\src\\main\\scala\\vga\\Ball.scala 35:47]
  wire [10:0] _P1yOverlap_T_5 = $signed(_P1yOverlap_T_2) - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 35:77]
  wire [10:0] _P1yOverlap_T_9 = $signed(io_P1Pos_1) + 11'sh40; // @[\\src\\main\\scala\\vga\\Ball.scala 35:134]
  wire [10:0] _P1yOverlap_T_12 = $signed(_P1yOverlap_T_9) + 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 35:164]
  wire  P1yOverlap = $signed(curPos_1) > $signed(_P1yOverlap_T_5) & $signed(curPos_1) < $signed(_P1yOverlap_T_12); // @[\\src\\main\\scala\\vga\\Ball.scala 35:106]
  wire [10:0] _P2xOverlap_T_2 = 11'sh240 - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 37:47]
  wire [10:0] _P2xOverlap_T_5 = $signed(_P2xOverlap_T_2) - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 37:76]
  wire  P2xOverlap = $signed(curPos_0) > $signed(_P2xOverlap_T_5) & $signed(curPos_0) < 11'sh250; // @[\\src\\main\\scala\\vga\\Ball.scala 37:105]
  wire [10:0] _P2yOverlap_T_2 = $signed(io_P2Pos_1) - 11'sh40; // @[\\src\\main\\scala\\vga\\Ball.scala 38:47]
  wire [10:0] _P2yOverlap_T_5 = $signed(_P2yOverlap_T_2) - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 38:77]
  wire [10:0] _P2yOverlap_T_9 = $signed(io_P2Pos_1) + 11'sh40; // @[\\src\\main\\scala\\vga\\Ball.scala 38:134]
  wire [10:0] _P2yOverlap_T_12 = $signed(_P2yOverlap_T_9) + 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 38:164]
  wire  P2yOverlap = $signed(curPos_1) > $signed(_P2yOverlap_T_5) & $signed(curPos_1) < $signed(_P2yOverlap_T_12); // @[\\src\\main\\scala\\vga\\Ball.scala 38:106]
  wire [10:0] _ballSpeed_T_2 = $signed(ballSpeed) + 11'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 46:30]
  wire [10:0] left = $signed(curPos_0) - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 51:26]
  wire [10:0] right = $signed(curPos_0) + 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 52:26]
  wire [10:0] top = $signed(curPos_1) - 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 53:26]
  wire [10:0] bottom = $signed(curPos_1) + 11'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 54:26]
  wire  inSquare = $signed(io_pos_0) > $signed(left) & $signed(io_pos_0) < $signed(right) & $signed(io_pos_1) > $signed(
    top) & $signed(io_pos_1) < $signed(bottom); // @[\\src\\main\\scala\\vga\\Ball.scala 56:180]
  wire [10:0] _inTopLeft_T_2 = $signed(curPos_0) - 11'sh4; // @[\\src\\main\\scala\\vga\\Ball.scala 57:46]
  wire  _inTopLeft_T_3 = $signed(io_pos_0) < $signed(_inTopLeft_T_2); // @[\\src\\main\\scala\\vga\\Ball.scala 57:34]
  wire [10:0] _inTopLeft_T_6 = $signed(curPos_1) - 11'sh4; // @[\\src\\main\\scala\\vga\\Ball.scala 57:103]
  wire  _inTopLeft_T_7 = $signed(io_pos_1) < $signed(_inTopLeft_T_6); // @[\\src\\main\\scala\\vga\\Ball.scala 57:91]
  wire  inTopLeft = $signed(io_pos_0) < $signed(_inTopLeft_T_2) & $signed(io_pos_1) < $signed(_inTopLeft_T_6); // @[\\src\\main\\scala\\vga\\Ball.scala 57:77]
  wire [10:0] _inTopRight_T_2 = $signed(curPos_0) + 11'sh4; // @[\\src\\main\\scala\\vga\\Ball.scala 58:46]
  wire  _inTopRight_T_3 = $signed(io_pos_0) > $signed(_inTopRight_T_2); // @[\\src\\main\\scala\\vga\\Ball.scala 58:34]
  wire  inTopRight = $signed(io_pos_0) > $signed(_inTopRight_T_2) & _inTopLeft_T_7; // @[\\src\\main\\scala\\vga\\Ball.scala 58:77]
  wire [10:0] _inBottomLeft_T_6 = $signed(curPos_1) + 11'sh4; // @[\\src\\main\\scala\\vga\\Ball.scala 59:103]
  wire  _inBottomLeft_T_7 = $signed(io_pos_1) > $signed(_inBottomLeft_T_6); // @[\\src\\main\\scala\\vga\\Ball.scala 59:91]
  wire  inBottomLeft = _inTopLeft_T_3 & $signed(io_pos_1) > $signed(_inBottomLeft_T_6); // @[\\src\\main\\scala\\vga\\Ball.scala 59:77]
  wire  inBottomRight = _inTopRight_T_3 & _inBottomLeft_T_7; // @[\\src\\main\\scala\\vga\\Ball.scala 60:77]
  wire  inDiamond = ~(inTopLeft | inTopRight | inBottomLeft | inBottomRight); // @[\\src\\main\\scala\\vga\\Ball.scala 62:19]
  assign io_inbound = inSquare & inDiamond; // @[\\src\\main\\scala\\vga\\Ball.scala 64:26]
  assign io_outLeftBound = $signed(curPos_0) < 11'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 68:32]
  assign io_outRightBound = $signed(curPos_0) > 11'sh280; // @[\\src\\main\\scala\\vga\\Ball.scala 67:33]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
      ballSpeed <= 11'sh2; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 24:24]
      if (!(goingLeft & (P1xOverlap & P1yOverlap))) begin // @[\\src\\main\\scala\\vga\\Ball.scala 40:51]
        if (~goingLeft & (P2xOverlap & P2yOverlap)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 43:58]
          ballSpeed <= _ballSpeed_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 46:17]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_0 <= 11'sh140; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 24:24]
      curPos_0 <= _curPos_0_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 27:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_1 <= 11'shf0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 24:24]
      curPos_1 <= _curPos_1_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 28:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
      velocity_0 <= 11'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 24:24]
      if (goingLeft & (P1xOverlap & P1yOverlap)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 40:51]
        velocity_0 <= ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 41:19]
      end else if (~goingLeft & (P2xOverlap & P2yOverlap)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 43:58]
        velocity_0 <= _velocity_1_T_7; // @[\\src\\main\\scala\\vga\\Ball.scala 44:19]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
      velocity_1 <= 11'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 24:24]
      if (goingLeft & (P1xOverlap & P1yOverlap)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 40:51]
        velocity_1 <= newYSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 42:19]
      end else if (~goingLeft & (P2xOverlap & P2yOverlap)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 43:58]
        velocity_1 <= newYSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 45:19]
      end else begin
        velocity_1 <= _velocity_1_T_9; // @[\\src\\main\\scala\\vga\\Ball.scala 26:17]
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
  ballSpeed = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  curPos_0 = _RAND_1[10:0];
  _RAND_2 = {1{`RANDOM}};
  curPos_1 = _RAND_2[10:0];
  _RAND_3 = {1{`RANDOM}};
  velocity_0 = _RAND_3[10:0];
  _RAND_4 = {1{`RANDOM}};
  velocity_1 = _RAND_4[10:0];
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
  output [1:0]  io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  output [1:0]  io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  output [1:0]  io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input  [10:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input  [10:0] io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input         io_input1, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input         io_input2, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input         io_screenDone // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
);
  wire  P1_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [10:0] P1_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [10:0] P1_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [10:0] P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_sideX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P2_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_sideX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  Ball_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_P1Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_P2Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_outLeftBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  XOR0 = io_indexX[0] ^ io_indexY[0]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 58:27]
  wire  XOR1 = io_indexX[1] ^ io_indexY[1]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:27]
  wire  XOR2 = io_indexX[2] ^ io_indexY[2]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:27]
  wire  XOR3 = io_indexX[3] ^ io_indexY[3]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 61:27]
  wire  XOR4 = io_indexX[4] ^ io_indexY[4]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:27]
  wire  XOR5 = io_indexX[5] ^ io_indexY[5]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:27]
  wire  dithered1 = XOR5 ^ XOR2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:26]
  wire  dithered2 = XOR4 ^ XOR1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 67:26]
  wire  dithered3 = XOR3 ^ XOR0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:26]
  wire [3:0] ditheringIntensity = {XOR0,io_indexY[0],XOR1,io_indexY[1]}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:31]
  wire  ditheringShadow = ditheringIntensity < 4'h8; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 71:44]
  wire [1:0] IntensityCat = {ditheringShadow,1'h0}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 72:25]
  wire [1:0] paddle1Fill = ~P1_io_sideX ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:27]
  wire [1:0] _io_col_R_T = IntensityCat | paddle1Fill; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 76:30]
  wire [1:0] paddle2Fill = P2_io_sideX ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:27]
  wire [1:0] _io_col_G_T = IntensityCat | paddle2Fill; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 82:30]
  wire  _GEN_0 = Ball_io_inbound ? 1'h0 : dithered1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 84:32 85:14 90:14]
  wire [1:0] _GEN_1 = Ball_io_inbound ? IntensityCat : {{1'd0}, dithered2}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 84:32 86:14 91:14]
  wire [1:0] _GEN_2 = Ball_io_inbound ? IntensityCat : {{1'd0}, dithered3}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 84:32 87:14 92:14]
  wire  _GEN_3 = P2_io_inbound ? 1'h0 : _GEN_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 79:30 81:14]
  wire [1:0] _GEN_4 = P2_io_inbound ? _io_col_G_T : _GEN_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 79:30 82:14]
  wire [1:0] _GEN_5 = P2_io_inbound ? 2'h0 : _GEN_2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 79:30 83:14]
  PaddleObj P1 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
    .clock(P1_clock),
    .reset(P1_reset),
    .io_input(P1_io_input),
    .io_pos_0(P1_io_pos_0),
    .io_pos_1(P1_io_pos_1),
    .io_inbound(P1_io_inbound),
    .io_paddlePos_1(P1_io_paddlePos_1),
    .io_updateLogic(P1_io_updateLogic),
    .io_sideX(P1_io_sideX)
  );
  PaddleObj_1 P2 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
    .clock(P2_clock),
    .reset(P2_reset),
    .io_input(P2_io_input),
    .io_pos_0(P2_io_pos_0),
    .io_pos_1(P2_io_pos_1),
    .io_inbound(P2_io_inbound),
    .io_paddlePos_1(P2_io_paddlePos_1),
    .io_updateLogic(P2_io_updateLogic),
    .io_sideX(P2_io_sideX)
  );
  BallObj Ball ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
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
  assign io_col_R = P1_io_inbound ? _io_col_R_T : {{1'd0}, _GEN_3}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 74:24 76:14]
  assign io_col_G = P1_io_inbound ? 2'h0 : _GEN_4; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 74:24 77:14]
  assign io_col_B = P1_io_inbound ? 2'h0 : _GEN_5; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 74:24 78:14]
  assign P1_clock = clock;
  assign P1_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 53:46]
  assign P1_io_input = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:15]
  assign P1_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:36]
  assign P1_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:53]
  assign P1_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 39:21]
  assign P2_clock = clock;
  assign P2_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 53:46]
  assign P2_io_input = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 42:15]
  assign P2_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:36]
  assign P2_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:53]
  assign P2_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 44:21]
  assign Ball_clock = clock;
  assign Ball_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 53:46]
  assign Ball_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:36]
  assign Ball_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:53]
  assign Ball_io_P1Pos_1 = P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 47:17]
  assign Ball_io_P2Pos_1 = P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 48:17]
  assign Ball_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 50:23]
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
  wire  graphics_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [1:0] graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [1:0] graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [1:0] graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [9:0] graphics_io_indexX; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [9:0] graphics_io_indexY; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire  graphics_io_screenDone; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire  graphics_io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire  graphics_io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  reg [9:0] hCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap = hCounter == 10'h31f; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_1 = hCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  reg [9:0] vCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap_1 = vCounter == 10'h20c; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_3 = vCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  GraphicsManager graphics ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
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
  assign io_col_R = graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:12]
  assign io_col_G = graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 35:12]
  assign io_col_B = graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:12]
  assign io_hsync = hCounter > 10'h28f & hCounter < 10'h2f0 ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:18]
  assign io_vsync = vCounter > 10'h1e9 & vCounter < 10'h1ec ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 40:18]
  assign graphics_clock = clock;
  assign graphics_io_indexX = hCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:22]
  assign graphics_io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:22]
  assign graphics_io_screenDone = wrap_wrap & wrap_wrap_1; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  assign graphics_io_input1 = io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 32:22]
  assign graphics_io_input2 = io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:22]
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



module tt_um_example (
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
        .io_col_R(uo_out[1:0]),
        .io_col_G(uo_out[3:2]),
        .io_col_B(uo_out[5:4]),
        .io_hsync(uo_out[6]),
        .io_vsync(uo_out[7]),
        .io_input1(ui_in[0]),
        .io_input2(ui_in[1])
    
    );

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:2], uio_in[7:0], clk, rst_n, 1'b0};

endmodule
