#Objects definitions
OBJS1 = ALU_Controller_testbench.v
EXEC1 = ALU_Controller
VCD1 = alu_controller.vcd
OUT1 = alu_controller.out
DEP1 = ./../Verilog_Modules/alu_control.v

# Applications
VVP = vvp
GTK = gtkwave

CC = iverilog
MK = make

#Debugging flag

DEBUG = -d

# Verbose flag
VERB = -v

#Warning flag
WARN = -Wall

#Synthesize flag
SYNTHE = -S

#Executable file generation flag
OUT = -o

#General Rules

all:
	$(CC) $(OUT) $(EXEC1) $(OBJS1)
	$(VVP) $(EXEC1)
	$(GTK) $(VCD1)

ALU_Controller_debug:
	$(CC) $(DEBUG) $(WARN) $(VERB) $(OBJS1) 

ALU_Controller_compile:
	$(CC) $(OUT) $(EXEC1) $(OBJS1)
	$(VVP) $(EXEC1) $(OUT1)

ALU_Controller_all:
	$(CC) $(OUT) $(EXEC1) $(OBJS1)
	$(VVP) $(EXEC1) $(OUT1)
	$(GTK) $(VCD1)

#Dependencies
$(OBJS1): $(DEP1)
	$(MK)

help:
	echo "make all; #Compiles, vvp, gtkwave"
	echo "make compile; #Compiles, vvp"
	echo "make debug; #Compiles"
	echo "make help; #shows this help"

clean :
	-@rm -rf *.o *~ $(EXEC1) $(VCD1) documentacion/ 2>/dev/null || true
	clear

