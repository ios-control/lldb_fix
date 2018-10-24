CFLAGS   = -shared -fpic -fobjc-link-runtime /usr/lib/libxcselect.dylib
CC       = clang
SDK_ROOT := `xcrun -sdk macosx -show-sdk-path`
DS_OUTPUT := "plugin load \"$(PWD)/lldb_fix.dylib\""
test:
	@echo $(DS_CLEAN_OUTPUT)

all: lldb_fix.c
	$(CC) $? -isysroot $(SDK_ROOT) -o lldb_fix.dylib $(CFLAGS)	
	@echo \\nbuild success!

install: all
	@echo Adding $(DS_OUTPUT) .lldbinit file...\\n
	/usr/bin/grep -q -F $(DS_OUTPUT) ~/.lldbinit || echo  $(DS_OUTPUT) >> ~/.lldbinit

clean:
	-rm -f lldb_fix.dylib
	sed -i -e '/plugin load .*lldb_fix.dylib/d' ~/.lldbinit
	@echo Removed $(DS_OUTPUT) in .lldbinit file
