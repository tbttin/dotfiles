# Features:
#   - Automatically generate and include dependencies.
#   - A clean project structure:
#     .
#     |-- include
#     |   |
#     |   `--defs.h
#     |-- src
#     |   |-- main.c
#     |   |-- defs.c
#     |-- build
#     |   |-- dep
#     |   |   |-- main.d
#     |   |   `-- defs.d
#     |   |-- obj
#     |   |   |-- main.o
#     |   |   `-- defs.o
#     |   `-- prog
#     |-- Makefile
#     `-- tags

CC            := /usr/bin/gcc
CFLAGS        += -pedantic -Wall -Wextra -Wshadow -Wconversion \
                 -Wstrict-overflow=5 -Wformat=2 -Wfloat-equal
                 # -O3
DBGCFLAGS     += -g
		 # -DDEBUGGING
OUTPUT_OPTION  = -MMD -MP -MF $(dep_dir)/$*.d -o $(obj_dir)/$*.o
COMPILE.c      = $(CC) $(CFLAGS) $(OUTPUT_OPTION) -I $(incl_dir) -c
LINK.c        := $(CC)
MAKEFLAGS     += --no-builtin-rules --no-builtin-variables

rm    := /usr/bin/rm -r -f
mkdir := /usr/bin/mkdir -p
# Use --kinds-c=+p to include all function prototypes in header files.
ctags := /usr/bin/ctags

src_dir  := src
incl_dir := include
bld_dir  := build
obj_dir  := $(bld_dir)/obj
dep_dir  := $(bld_dir)/dep
dirs     := $(bld_dir) $(obj_dir) $(dep_dir)
# TODO: Wildcard is necessary/security risk?
sources  := $(wildcard $(src_dir)/*.c)
headers  := $(wildcard $(incl_dir)/*.h)
objs     := $(patsubst $(src_dir)/%.c,$(obj_dir)/%.o,$(sources))
prog     := $(bld_dir)/$(notdir $(CURDIR:%/=%))
tags     := tags

all: $(tags) $(prog)

$(tags):
	@$(ctags) $(sources) $(headers)

$(prog): $(objs)
	$(LINK.c) -o $@ $^

$(obj_dir)/%.o $(dep_dir)/%.d&: $(src_dir)/%.c | $(dirs)
	$(COMPILE.c) $<

$(dirs):
	@$(mkdir) -- $@

# If the make "goal" is irrelevant don't include dependency files.
# TODO: makefiles remake makes 'make --just-print' suck.
#   Reproduce: make clean && make --just-print
ifeq '$(filter-out all run $(prog),$(MAKECMDGOALS))' ''
-include $(patsubst $(src_dir)/%.c,$(dep_dir)/%.d,$(sources))
endif

# TODO: $(prog) is not updated when header files has been changed.
run: $(prog)
	@$(prog) $(RUN_ARGS) --

# Threads?
debug: clean
debug: CFLAGS += $(DBGCFLAGS)
debug: all

print-%: ; $(info $* = "$($*)", origin: $(origin $*), flavour: $(flavor $*)) @true

clean:
	$(rm) -- $(obj_dir)/ $(prog)
distclean:
	$(rm) -- $(bld_dir)/ $(tags)

.PHONY: all debug run clean distclean

# TODO:
# make run RUN_ARGS="--foo=bar --bar=baz"
#
# If the first argument is "run"...
ifeq '$(firstword $(MAKECMDGOALS))' 'run'
# use the rest as arguments for "run"
RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# ...and turn them into do-nothing targets:
#   + Semi colon mean target and recipe are in the same line.
#   + The '@:' is a recipe; '@' mean do it silently, the ':' in the
#   shell mean "NOP" (no op, a do-nothing operation).
$(eval $(RUN_ARGS): ; @:)
endif

