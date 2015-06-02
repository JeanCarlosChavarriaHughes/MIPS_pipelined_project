#Objects definitions
OBJS1 = ALU_Controller_testbench.v
EXEC1 = ALU_Controller
VCD1 = alu_controller.vcd
OUT1 = alu_controller.out
DEP1 = ./../Verilog_Modules/alu_control.v

OBJS2 = ALU_testbench.v
EXEC2 = ALU
VCD2 = alu.vcd
OUT2 = alu.out
DEP2 = ./../Verilog_Modules/alu.v

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
	#$(GTK) $(VCD1)
	$(CC) $(OUT) $(EXEC2) $(OBJS2)
	$(VVP) $(EXEC2)

ALU_Controller_debug:
	$(CC) $(DEBUG) $(WARN) $(VERB) $(OBJS1) 

ALU_Controller_compile:
	$(CC) $(OUT) $(EXEC1) $(OBJS1)
	$(VVP) $(EXEC1) $(OUT1)

ALU_Controller_all:
	$(CC) $(OUT) $(EXEC1) $(OBJS1)
	$(VVP) $(EXEC1) $(OUT1)
	$(GTK) $(VCD1)

ALU_debug:
	$(CC) $(DEBUG) $(WARN) $(VERB) $(OBJS2) 

ALU_compile:
	$(CC) $(OUT) $(EXEC2) $(OBJS2)
	$(VVP) $(EXEC2) $(OUT2)

ALU_all:
	$(CC) $(OUT) $(EXEC2) $(OBJS2)
	$(VVP) $(EXEC2) $(OUT2)
	$(GTK) $(VCD2)

#Dependencies
$(OBJS1): $(DEP1)
	$(MK) ALU_Controller_all

$(OBJS2): $(DEP2)
	$(MK) ALU_all

help:
	echo "make all; #Compiles, vvp, gtkwave"
	echo "make compile; #Compiles, vvp"
	echo "make debug; #Compiles"
	echo "make help; #shows this help"

clean :
	-@rm -rf *.o *.out *~ $(EXEC1) $(VCD1) $(EXEC2) $(VCD2) documentacion/ 2>/dev/null || true
	clear

