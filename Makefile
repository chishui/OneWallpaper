prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	swift build -c release --disable-sandbox

install: build
	install -d "$(bindir)" "$(libdir)"
	install ".build/release/one-wallpaper" "$(bindir)"
	install_name_tool -change \
		".build/x86_64-apple-macosx10.10/release/libSwiftSyntax.dylib" \
		"$(bindir)/one-wallpaper"

uninstall:
	rm -rf "$(bindir)/one-wallpaper"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
