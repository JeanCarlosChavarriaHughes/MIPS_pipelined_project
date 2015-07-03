#Objects definitions
OBJS3 = ALU_testbench.v
EXEC3 = ALU
VCD3 = alu.vcd
OUT3 = alu.out
DEP3 = ./../Verilog_Modules/alu.v

OBJS5 = ram_testbench.v
EXEC5 = RAM
VCD5 = ram.vcd
OUT5 = ram.out
DEP5 = ./../Verilog_Modules/data_ram.v

OBJS6 = branch_taken_testbench.v
EXEC6 = BTaken
VCD6 = branch_taken.vcd


OBJS1 = ALU_Controller_testbench.v
OBJS2 = inst_decode_testbench.v
OBJS4 = forwarding_testbench.v
EXEC1 = ALU_Controller
EXEC2 = Instruction_Decoder
EXEC4 = Forwarding_Unit
VCD1 = alu_controller.vcd
VCD2 = decoder.vcd
VCD4 = forward.vcd
OUT1 = alu_controller.out
OUT2 = decoder.out
DEP1 = ./../Verilog_Modules/alu_control.v

OBJSCPU = cpu_testbench.v
EXECCPU = CPU_Result
VCDCPU = cpu.vcd
OUTCPU = cpu.out


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

ALU_debug:
	$(CC) $(DEBUG) $(WARN) $(VERB) $(OBJS3) 

ALU_compile:
	$(CC) $(OUT) $(EXEC3) $(OBJS3)
	$(VVP) $(EXEC3) $(OUT3)

ALU_all:
	$(CC) $(OUT) $(EXEC3) $(OBJS3)
	$(VVP) $(EXEC3) $(OUT3)
	$(GTK) $(VCD3)

ram_debug:
	$(CC) $(DEBUG) $(WARN) $(VERB) $(OBJS5) 

ram_compile:
	$(CC) $(OUT) $(EXEC5) $(OBJS5)
	$(VVP) $(EXEC5) $(OUT5)

ram_all:
	$(CC) $(OUT) $(EXEC5) $(OBJS5)
	$(VVP) $(EXEC5) $(OUT5)
	$(GTK) $(VCD5) &

Decoder:
	$(CC) $(OUT) $(EXEC2) $(OBJS2)
	$(VVP) $(EXEC2) $(OUT2)

Forward:
	$(CC) $(OUT) $(EXEC4) $(OBJS4)
	$(VVP) $(EXEC4) $(OUT4)

BTaken:
	$(CC) $(OUT) $(EXEC6) $(OBJS6)
	$(VVP) $(EXEC6) $(OUT6)

Cpu:
	$(CC) $(OUT) $(EXECCPU) $(OBJSCPU)
	$(VVP) $(EXECCPU) $(OUTCPU)

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

