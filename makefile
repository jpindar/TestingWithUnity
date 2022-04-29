# makefile for building simple C programs with the Unity test framework
# Unity is from http://www.throwtheswitch.org
# This makefile is based on the examples from Unity
# 
# make main builds the main program
# make tests build the test runner with Unity
# make clean deletes the .o and .exe files
# make with no arguments executes the first rule in the makefile

# this file works in Git Bash
# it looks like it was supposed to work in Windows but it doesn't


ifeq ($(OS),Windows_NT)
  ifeq ($(shell uname -s),) # not in a bash-like shell
	CLEANUP = del /F /Q
	MKDIR = mkdir
  else # in a bash-like shell, like msys
	CLEANUP = rm -f
	MKDIR = mkdir -p
  endif
	TARGET_EXTENSION=exe
else
	CLEANUP = rm -f
	MKDIR = mkdir -p
	TARGET_EXTENSION=out
endif

.PHONY: clean
.PHONY: test
.PHONY: main

MAINSRC = mainfile

PATHU = unity/src/
PATHS = src/
PATHT = test/
PATHB = build/
PATHD = build/depends/
PATHO = build/objs/
PATHR = build/results/
PATHI = include/

BUILD_PATHS = $(PATHB) $(PATHD) $(PATHO) $(PATHR)

SRCT = $(wildcard $(PATHT)*.c)
SRCS = $(wildcard $(PATHS)*.c)

COMPILE=gcc -c
LINK=gcc
DEPEND=gcc -MM -MG -MF

CFLAGS=-I.
CFLAGS+= -I$(PATHU) -I$(PATHS) -I$(PATHI)
CFLAGS+= -DTEST

RESULTS = $(patsubst $(PATHT)Test%.c,$(PATHR)Test%.txt,$(SRCT) )
OBJECTFILES = $(patsubst $(PATHS)%.c,$(PATHO)%.o,$(SRCS) )

PASSED = `grep -s PASS $(PATHR)*.txt`
FAIL = `grep -s FAIL $(PATHR)*.txt`
IGNORE = `grep -s IGNORE $(PATHR)*.txt`

main: $(MAINSRC).$(TARGET_EXTENSION) $(PATHO)$(MAINSRC).o
	@echo "DONE"


# $(MAINSRC).$(TARGET_EXTENSION): $(PATHO)$(MAINSRC).o $(PATHO)library1.o $(PATHO)library2.o
# this will build all the .c files it finds in src/
$(MAINSRC).$(TARGET_EXTENSION): $(PATHO)$(MAINSRC).o $(OBJECTFILES)
	$(LINK) -o $@ $^


test: $(BUILD_PATHS) $(RESULTS)
	@echo "  "
	@echo "-----------------------IGNORES:-----------------------"
	@echo "$(IGNORE)"
	@echo "-----------------------FAILURES:-----------------------"
	@echo "$(FAIL)"
	@echo "-----------------------PASSED:-----------------------"
	@echo "$(PASSED)"
	@echo "DONE"

$(PATHR)%.txt: $(PATHB)%.$(TARGET_EXTENSION)
	-./$< > $@ 2>&1

# test file is named after the module it's testing
# for example,  test/TestLibrary1.exe    build/obj/TestLibrary1.o
$(PATHB)Test%.$(TARGET_EXTENSION): $(PATHO)Test%.o $(PATHO)%.o $(PATHO)unity.o
	$(LINK) -o $@ $^
	@echo "DONE"
	@echo " "

$(PATHO)%.o:: $(PATHT)%.c
	$(COMPILE) $(CFLAGS) $< -o $@

$(PATHO)%.o:: $(PATHS)%.c
	$(COMPILE) $(CFLAGS) $< -o $@

$(PATHO)%.o:: $(PATHU)%.c $(PATHU)%.h
	$(COMPILE) $(CFLAGS) $< -o $@

$(PATHD)%.d:: $(PATHT)%.c
	$(DEPEND) $@ $<

$(PATHB):
	$(MKDIR) $(PATHB)

$(PATHD):
	$(MKDIR) $(PATHD)

$(PATHO):
	$(MKDIR) $(PATHO)

$(PATHR):
	$(MKDIR) $(PATHR)

clean:
	$(CLEANUP) $(PATHO)*.o
	$(CLEANUP) $(PATHB)*.$(TARGET_EXTENSION)
	$(CLEANUP) $(PATHR)*.txt


.PRECIOUS: $(PATHB)Test%.$(TARGET_EXTENSION)
.PRECIOUS: $(PATHD)%.d
.PRECIOUS: $(PATHO)%.o
.PRECIOUS: $(PATHR)%.txt
