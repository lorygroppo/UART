'''
TestBench per UART
'''

import os

os.system("vsim -c -do simulation.do")
os.system("vsim -do waveform.do");