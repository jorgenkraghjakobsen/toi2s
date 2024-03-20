# ICW Build system 
# Written by Jørgen Kragh Jakobsen, November 2021

OFL=/home/jakobsen/work/opentools/openFPGAloader_/build/openFPGALoader
BOARD=tangnano9k
FAMILY=GW1N-9C
DEVICE=GW1NR-LV9QN88PC6/I5

#target = fpga
target = sim

pr  = ../..

PRO = toi2s
#PRO = amp_i2c_master



obj = $(pr)/obj/digital/$(PRO)/$(target)

VERILOG_FILES = ../amp_i2c_master/*.v \
			    ../amp_state_control/*.v \
			    ../i2c_if/*.v \
				../rb_toi2s/*.sv \
			    ../spdif_decoder/*.sv \
				../toi2s/*.sv
				
				
VERILOG_TB =  tb/$(PRO)_tb.v

all_sim: obj synth sim wave 

#Create obj if not pressent 
obj:
	mkdir -p $(obj)

synth: 
	echo $(VERILOG_FILES) ;\
	iverilog -g2012 -o $(obj)/$(PRO).vvp \
	-DDUMP="file.vcd" -D 'FPGA' \
	-s $(PRO)_tb \
	$(VERILOG_FILES) $(VERILOG_TB) 
	
	
#	''"$(obj)/$(BLOCK).vcd"' -D 'FPGA' 

sim: 
	vvp $(obj)/$(PRO).vvp
wave:   
	pwd ;\
	gtkwave $(PRO)_tb.vcd -a $(obj)/$(PRO).gtkw -W    


#-------------------------------------------------------------------------------------------
# FPGA Target 
#-------------------------------------------------------------------------------------------

all_fpga: synth place bit prog	

# Synthesis
$(PRO).json: $(PRO).sv
	yosys -p " \
	read_verilog ../amp_i2c_master/clk_div.v ; \
	read_verilog ../amp_i2c_master/amp_i2c_master.v ; \
	read_verilog ../amp_state_control/timer_simple.v ; \
	read_verilog ../amp_state_control/amp_state_control.v ; \
	read_verilog -sv ../spdif_decoder/spdif_decoder.sv ; \
	read_verilog -sv $(PRO).sv ; \
	synth_gowin -top $(PRO) -json $(PRO).json"

# Place and Route
$(PRO)_pnr.json: $(PRO).json
	nextpnr-gowin --json $(PRO).json --freq 27 --write $(PRO)_pnr.json --device ${DEVICE} --family ${FAMILY} --cst ${BOARD}.cst

# Generate Bitstream
$(PRO).fs: $(PRO)_pnr.json
	gowin_pack -d ${FAMILY} -o $(PRO).fs $(PRO)_pnr.json

# Program Board flash or RAM
flash: $(PRO).fs
	$(OFL) -b ${BOARD} $(PRO).fs -f

load: $(PRO).fs
	${OFL} -b ${BOARD} $(PRO).fs 



