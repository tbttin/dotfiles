CC            := /usr/bin/gcc
CFLAGS        += -pedantic -Wall -Wextra -Wshadow -Wconversion \
                 -Wstrict-overflow=5 -Wformat=2 -Wfloat-equal
DBGCFLAGS     += -g
OUTPUT_OPTION  = -MMD -MP -MF $(dep_dir)/$*.d -o $(obj_dir)/$*.o
COMPILE.c      = $(CC) $(CFLAGS) $(OUTPUT_OPTION) -I $(incl_dir) -c
LDLIBS        += -lm
LINK.c        := $(CC) $(LDLIBS)
MAKEFLAGS     += --no-builtin-rules --no-builtin-variables

src_dir  := src
incl_dir := include
bld_dir  := build
obj_dir  := $(bld_dir)/obj
dep_dir  := $(bld_dir)/dep
dirs     := $(bld_dir) $(obj_dir) $(dep_dir)
# Wildcard is necessary/security risk?
sources  := $(wildcard $(src_dir)/*.c)
headers  := $(wildcard $(incl_dir)/*.h)
objs     := $(patsubst $(src_dir)/%.c,$(obj_dir)/%.o,$(sources))
prog     := $(bld_dir)/$(notdir $(CURDIR:%/=%))
tags     := tags
rm       := /usr/bin/rm -r -f
mkdir    := /usr/bin/mkdir -p
# Use --kinds-c=+p to include all function prototypes in header files.
ctags    := /usr/bin/ctags

all: $(tags) $(prog)

$(tags): $(sources) $(headers)
	$(ctags) -f $@ $(sources) $(headers)

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

run: $(prog)
	@$(prog) $(RUN_ARGS) --

# Threads?
debug: clean
debug: CFLAGS += $(DBGCFLAGS)
debug: all

print-%: ; $(info $* = "$($*)", origin: $(origin $*), flavour: $(flavor $*)) @:

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

