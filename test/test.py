# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, Timer

class VGA_Signals:
    def __init__(self, dut):
        self.dut = dut
    
    def hsync(self):
        return self.dut.uo_out[7]
    
    def vsync(self):
        return self.dut.uo_out[3]

async def HsyncFall(dut):
    if (dut.uo_out.value[7] == 0):
    while dut.uo_out.value[7] == 0:
        await RisingEdge(dut.clk)
    
    while dut.uo_out.value[7] == 1:
        await FallingEdge(dut.clk)

async def HsyncRise(dut):
    if (dut.uo_out.value[7] == 1):
     while dut.uo_out.value[7] == 1:
        await FallingEdge(dut.clk)
         
     while dut.uo_out.value[7] == 0:
        await RisingEdge(dut.clk)

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
    assert dut.uo_out.value[7] == 1
    assert dut.uo_out.value[3] == 1

    dut._log.info("Reset pressed (checking if reset synchronizer isn't fucked).")
    await resetDUT(dut)
    dut._log.info("Reset released.")

    dut._log.info("Testing Hsync")
    await HsyncFall(dut)
    startTime = cocotb.utils.get_sim_time(unit='ns')
    await HsyncRise(dut)
    endTime = cocotb.utils.get_sim_time(unit='ns')
    
    pulseWidthCycles = (endTime - startTime) / 40 
    assert pulseWidthCycles == 96

    dut._log.info("Testing If data is being written to the screen")
    await HsyncRise(dut)
    await ClockCycles(dut.clk, 50)
    
    assert (dut.uo_out.value[0] + dut.uo_out.value[1] + dut.uo_out.value[2] + dut.uo_out.value[4]  + dut.uo_out.value[5] + dut.uo_out.value[6] != 0)
