# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, Timer

class VGA_Signals:
    def __init__(self, dut):
        self.dut = dut
    
    @property
    def hsync(self):
        return self.dut.uo_out
    
    @property
    def vsync(self):
        return self.dut.uo_out

async def resetDUT(dut):
    dut.rst_n.value = 0
    dut.ena.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 40, unit="ns")
    cocotb.start_soon(clock.start())
    vga = VGA_Signals(dut)

    dut._log.info("Testing if VGA is valid during reset.")
    dut.rst_n.value = 0
    dut.ena.value = 1
    await ClockCycles(dut.clk, 5)
    assert vga.hsync == 1
    assert vga.vsync == 1

    dut._log.info("Reset pressed (checking if reset synchronizer isn't fucked).")
    await resetDUT(dut)
    dut._log.info("Reset released.")

    dut._log.info("Testing Hsync")
    await FallingEdge(vga.hsync)
    start_time = cocotb.utils.get_sim_time(unit='ns')
    await RisingEdge(vga.hsync)
    end_time = cocotb.utils.get_sim_time(unit='ns')
    
    pulse_width_cycles = (end_time - start_time) / 40 
    assert pulse_width_cycles == 96

    dut._log.info("Testing If data is being written to the screen")
    await RisingEdge(vga.hsync)
    await ClockCycles(dut.clk, 50)

    assert dut.uo_out.value != 0
