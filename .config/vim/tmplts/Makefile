CC        := cc
CFLAGS     = -std=c17 -pedantic -Wall -Wextra -O2 -Wshadow -Wconversion -Wstrict-overflow=5 -Wformat=2 -Wfloat-equal -o $(OBJ_DIR)/$*.o
#LDLIBS    := -lm
DBGCFLAGS := -g -DDEBUGGING
DEPFLAGS   = -MMD -MP -MF $(DEP_DIR)/$*.d
MAKEFLAGS := --no-builtin-rules --no-builtin-variables

RM        := rm -rf
MKDIR     := @mkdir -p
SRC_DIR   := src
OBJ_DIR   := obj
BIN_DIR   := bin
DEP_DIR   := .deps
DIRS      := $(OBJ_DIR) $(BIN_DIR) $(DEP_DIR)
PROG      := $(BIN_DIR)/prog.out
SOURCES   := $(wildcard $(SRC_DIR)/*.c)
OBJS      := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SOURCES))

all: $(PROG)

debug: clean
debug: CFLAGS += $(DBGCFLAGS)
debug: all

clean:
	$(RM) $(DIRS)

run:
	-@./$(PROG)

$(PROG): $(OBJS) | $(BIN_DIR)
	$(CC) $^ -o $@

$(OBJ_DIR)/%.o $(DEP_DIR)/%.d&: $(SRC_DIR)/%.c | $(OBJ_DIR) $(DEP_DIR)
	$(CC) $(CFLAGS) $(DEPFLAGS) -c $<

$(DIRS):
	$(MKDIR) $@

# If the make goal is irrelevant don't include dependency files.
ifeq (,$(filter $(MAKECMDGOALS),clean run))
# If an included makefile cannot be found in any of these directories, a warning message is generated, but it is not an immediately fatal error; \
# processing of the makefile containing the include continues. Once it has finished reading makefiles, make will try to remake any that are \
# out of date or don’t exist. See How Makefiles Are Remade. Only after it has tried to find a way to remake a makefile and failed, \
# will make diagnose the missing makefile as a fatal error.
# We can use shell file name patterns with include directive too.
-include $(patsubst $(SRC_DIR)/%.c,$(DEP_DIR)/%.d,$(SOURCES))
endif

.PHONY: all debug clean run

# Expansion of a deferred construct part is delayed until the expansion is used: either when it is referenced in an immediate context, \
# or when it is needed during the second phase.
# 	immediate   = deferred
# 	immediate  ?= deferred
# 	immediate  := immediate
# 	immediate ::= immediate
# 	immediate  += deferred or immediate (depend on right-hand side)
# 	immediate  != immediate

.PHONY: test
test:
	@echo MAKEFLAGS: $(MAKEFLAGS)
