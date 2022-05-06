# Features:
#   - Automatically generate and include dependencies.
#   - Clean project structure:
#     (tree --charset=ascii --dirsfirst)
#     .
#     |-- build
#     |   |-- dep
#     |   |   |-- main.d
#     |   |   `-- defs.d
#     |   |-- obj
#     |   |   |-- main.o
#     |   |   `-- defs.o
#     |   `-- prog
#     |-- src
#     |   |-- main.c
#     |   |-- defs.c
#     |   `-- defs.h
#     |-- Makefile
#     `-- tags

CC            := /usr/bin/gcc
CFLAGS        += -pedantic -Wall -Wextra -O3 -Wshadow -Wconversion\
                 -Wstrict-overflow=5 -Wformat=2 -Wfloat-equal
DBGCFLAGS     += -g -DDEBUGGING
OUTPUT_OPTION  = -MMD -MP -MF $(dep_dir)/$*.d -o $(obj_dir)/$*.o
COMPILE.c      = $(CC) $(CFLAGS) $(OUTPUT_OPTION) -c
LINK.c        := $(CC)
MAKEFLAGS     += --no-builtin-rules --no-builtin-variables

src_dir := src
bld_dir := build
obj_dir := $(bld_dir)/obj
dep_dir := $(bld_dir)/dep
prog    := $(bld_dir)/prog
dirs    := $(bld_dir) $(obj_dir) $(dep_dir)
sources := $(wildcard $(src_dir)/*.c)
headers := $(wildcard $(src_dir)/*.h)
objs    := $(patsubst $(src_dir)/%.c,$(obj_dir)/%.o,$(sources))
rm      := /usr/bin/rm --recursive --force --
mkdir   := /usr/bin/mkdir --parents --
tags    := /usr/bin/ctags

# Default goal.
all: tags $(prog)

# Threads?
debug: clean
debug: private CFLAGS += $(DBGCFLAGS)
debug: all

$(prog): $(objs)
	$(LINK.c) -o $@ $^

$(obj_dir)/%.o $(dep_dir)/%.d&: $(src_dir)/%.c | $(dirs)
	$(COMPILE.c) $<

$(dirs):
	@$(mkdir) $@

tags:
	@$(tags) $(sources) $(headers)

run: $(prog)
	@$(prog) $(RUN_ARGS)

clean:
	$(rm) $(bld_dir)/ tags
clean-obj:
	$(rm) $(obj_dir)/
clean-dep:
	$(rm) $(dep_dir)/

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
# use the rest as arguments for "run"
RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# ...and turn them into do-nothing targets:
#   + Semi colon mean target and recipe are in the same line.
#   + The '@:' is a recipe; '@' means do it silently, the ':' means do
#   nothing.
$(eval $(RUN_ARGS): ; @:)
endif

# If the make "goal" is irrelevant don't include dependency files.
# TODO: makefile remake makes 'make --just-print' suck.
ifeq ($(filter-out all,$(MAKECMDGOALS)),)
-include $(patsubst $(src_dir)/%.c,$(dep_dir)/%.d,$(sources))
endif

.PHONY: all debug clean clean-obj clean-dep run tags

## Some notes
#
# Debugging makefile
# make --just-print --print-data-base 2>&1 | less
#
# $(warning warn: '$(filter-out all,$(MAKECMDGOALS))')
# $(info info: 'bla blah')
#
# Log a long-run makefile
# make -k > build.log 2>&1

