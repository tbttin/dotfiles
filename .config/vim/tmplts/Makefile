# Features:
# - Dependencies tracking.
# - Clean project structure:
#   (tree --charset=ascii --dirsfirst)
#   .
#   |-- build
#   |   |-- dep
#   |   |   |-- main.d
#   |   |   `-- utils.d
#   |   |-- obj
#   |   |   |-- main.o
#   |   |   `-- utils.o
#   |   `-- prog
#   |-- src
#   |   |-- main.c
#   |   |-- utils.c
#   |   `-- utils.h
#   |-- Makefile
#   `-- tags

CC            := /usr/bin/gcc
CFLAGS        += -pedantic -Wall -Wextra -O3 -Wshadow -Wconversion -Wstrict-overflow=5 -Wformat=2 -Wfloat-equal
DBGCFLAGS     += -g -DDEBUGGING
OUTPUT_OPTION  = -MMD -MP -MF $(dep_dir)/$*.d -o $(obj_dir)/$*.o
MAKEFLAGS     += --no-builtin-rules --no-builtin-variables
COMPILE.c      = $(CC) $(CFLAGS) $(OUTPUT_OPTION) -c
LINK.c        := $(CC)

src_dir := src
bld_dir := build
obj_dir := $(bld_dir)/obj
dep_dir := $(bld_dir)/dep
sources := $(wildcard $(src_dir)/*.c)
headers := $(wildcard $(src_dir)/*.h)
objs    := $(patsubst $(src_dir)/%.c,$(obj_dir)/%.o,$(sources))
prog    := $(bld_dir)/prog
dirs    := $(obj_dir) $(dep_dir)
rm      := /usr/bin/rm --recursive --force --
mkdir   := /usr/bin/mkdir --parents --
tags    := /usr/bin/ctags

all: tags $(prog)

# Threads?
debug: clean
debug: CFLAGS += $(DBGCFLAGS)
debug: all

$(prog): $(objs)
	$(LINK.c) -o $@ $^

$(obj_dir)/%.o $(dep_dir)/%.d &: $(src_dir)/%.c | $(dirs)
	$(COMPILE.c) $<

$(dirs):
	@$(mkdir) $@

tags:
	@$(tags) $(sources) $(headers)

run: $(prog)
	@$(prog) $(RUN_ARGS)

clean:
	$(rm) tags $(bld_dir)/
clean-obj:
	$(rm) $(obj_dir)/
clean-dep:
	$(rm) $(dep_dir)/

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
# use the rest as arguments for "run"
RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# ...and turn them into do-nothing targets.
# Semi colon mean target and recipe are in the same line.
# The @: is a recipe; the : means do nothing, and the @ means do it silently.
$(eval $(RUN_ARGS): ; @:)
endif

# If the make goal is irrelevant don't include dependency files.
ifeq ($(filter-out all,$(MAKECMDGOALS)),)
# If an included makefile cannot be found in any of include directories, a warning message is generated,
# but it is not an immediately fatal error; processing of the makefile containing the include continues.
# Once it has finished reading makefiles, make will try to remake any that are out of date or don’t exist.
# See How Makefiles Are Remade. Only after it has tried to find a way to remake a makefile and failed,
# will make diagnose the missing makefile as a fatal error.
-include $(patsubst $(src_dir)/%.c,$(dep_dir)/%.d,$(sources))
endif

.PHONY: all debug clean clean-obj clean-dep run tags

# Debugging
# $(warning warn: '$(filter-out all,$(MAKECMDGOALS))')
# $(info info: 'bla blah')

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

