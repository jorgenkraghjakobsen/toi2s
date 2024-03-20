
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

@cocotb.test()
async def run_test(dut):
  PERIOD = 10

  dut.clk_in = 0
  dut.resetb = 0
  dut.send_cfg = 0
  dut.sda = 0
  dut.scl = 0


  await Timer(20*PERIOD, units='ns')


  dut.clk_in = 0
  dut.resetb = 0
  dut.send_cfg = 0
  dut.sda = 0
  dut.scl = 0


  await Timer(20*PERIOD, units='ns')


# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()