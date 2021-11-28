CC            := cc
CFLAGS        += -std=c17 -pedantic -Wall -Wextra -O2 -Wshadow -Wconversion -Wstrict-overflow=5 -Wformat=2 -Wfloat-equal
DBGCFLAGS     += -g -DDEBUGGING
OUTPUT_OPTION += -MMD -MP -MF $(dep_dir)/$*.d -o $(obj_dir)/$*.o
MAKEFLAGS     += --no-builtin-rules --no-builtin-variables

src_dir       := $(CURDIR)/src
obj_dir       := $(CURDIR)/obj
bin_dir       := $(CURDIR)/bin
dep_dir       := $(CURDIR)/.deps
dirs          := $(obj_dir) $(bin_dir) $(dep_dir)
prog          := $(bin_dir)/prog
rm            := rm -rf
mkdir         := mkdir -p
tags          := ctags $(src_dir)/*.{h,c}
sources       := $(wildcard $(src_dir)/*.c)
objs          := $(patsubst $(src_dir)/%.c,$(obj_dir)/%.o,$(sources))

all: $(prog) tags

debug: clean
debug: CFLAGS += $(DBGCFLAGS)
debug: all

clean:
	$(rm) $(dirs)

run:
	@$(prog)

tags:
	@$(tags)

$(prog): $(objs) | $(bin_dir)
	$(CC) $^ -o $@

$(obj_dir)/%.o $(dep_dir)/%.d&: $(src_dir)/%.c | $(obj_dir) $(dep_dir)
	$(CC) $(CFLAGS) $(OUTPUT_OPTION) -c $<

$(dirs):
	@$(mkdir) $@

# $(warning warn: '$(filter-out all,$(MAKECMDGOALS))')
# TODO:
# 	- Fix: make clean && make "invalid target".
# 	- make mul ti tar get
# If the make goal is irrelevant don't include dependency files.
ifeq ($(filter-out all,$(MAKECMDGOALS)),)
# If an included makefile cannot be found in any of include directories, a warning message is generated,
# but it is not an immediately fatal error; processing of the makefile containing the include continues.
# Once it has finished reading makefiles, make will try to remake any that are out of date or don’t exist.
# See How Makefiles Are Remade. Only after it has tried to find a way to remake a makefile and failed,
# will make diagnose the missing makefile as a fatal error.
-include $(patsubst $(src_dir)/%.c,$(dep_dir)/%.d,$(sources))
endif

.PHONY: all debug clean run tags

# Expansion of a deferred construct part is delayed until the expansion is used: either when it is referenced in an immediate context,
# or when it is needed during the second phase.
# 	immediate   = deferred
# 	immediate  ?= deferred
# 	immediate  := immediate
# 	immediate ::= immediate
# 	immediate  += deferred or immediate (depend on left-hand side)
# 	immediate  != immediate

file_list != find . -name '*.c'
foo = $(bar)
bar = $(ugh)
ugh = Huh?
.PHONY: test
test:
	echo $(tags)
# 	echo $(.VARIABLES)
# 	@echo $(MAKE_TERMOUT) $(MAKE_TERMERR)
# 	echo $(file_list)
# 	echo $(foo)
# 	echo $(MAKEFLAGS)
# 	$(MAKE) -C src
# 	make -C src
