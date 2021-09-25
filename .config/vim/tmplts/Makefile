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
PROG      := $(BIN_DIR)/prog.out
SOURCES   := $(wildcard $(SRC_DIR)/*.c)
OBJS      := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SOURCES))

.PHONY: all debug clean run

all: $(PROG)

debug: clean
debug: CFLAGS += $(DBGCFLAGS)
debug: all

clean:
	$(RM) $(OBJ_DIR) $(BIN_DIR) $(DEP_DIR)

run:
	-@./$(PROG)

$(PROG): $(OBJS) | $(BIN_DIR)
	$(CC) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR) $(DEP_DIR)
	$(CC) $(CFLAGS) $(DEPFLAGS) -c -o $@ $<

$(BIN_DIR): ; $(MKDIR) $@

$(OBJ_DIR): ; $(MKDIR) $@

$(DEP_DIR): ; $(MKDIR) $@

# If the make goal is irrelevant don't include dependency files.
ifneq ($(MAKECMDGOALS),$(or clean,run))
-include := $(patsubst $(SRC_DIR)/%.c,$(DEP_DIR)/%.d,$(SOURCES))
endif
