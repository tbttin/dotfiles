CC        := cc
CFLAGS    := -std=c17 -pedantic -Wall -Wextra -O2 -Wshadow -Wconversion -Wstrict-overflow=5 -Wformat=2 -Wfloat-equal
#LDLIBS    := -lm
DBGCFLAGS := -g -DDEBUGGING
DEPFLAGS   = -MMD -MP -MF $(DEP_DIR)/$*.d

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

.PHONY: a all debug clean run

all: $(PROG)

debug: clean
debug: CFLAGS += $(DBGCFLAGS)
debug: all

clean:
	$(RM) $(DIRS)

run:
	-@./$(PROG)

$(PROG): $(OBJS) | $(BIN_DIR)
	$(CC) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR) $(DEP_DIR)
	$(CC) $(CFLAGS) $(DEPFLAGS) -c -o $@ $<

$(DIRS):
	$(MKDIR) $@

# If the make goal is irrelevant don't include dependency files.
ifeq (,$(filter $(MAKECMDGOALS),clean run))
# Wew can use shell file name patterns with include directive too.
include $(patsubst $(SRC_DIR)/%.c,$(DEP_DIR)/%.d,$(SOURCES))
endif
