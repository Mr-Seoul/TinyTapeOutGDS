# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    clock = Clock(dut.clk, 40, units="ns")
    cocotb.start_soon(clock.start())

    dut.rst_n.value = 0
    await Timer(100, units="ns")
    dut.rst_n.value = 1

    for _ in range(1000):
        await RisingEdge(dut.clk)

    assert dut.uo_out.value != 0
