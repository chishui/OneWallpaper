prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	swift build -c release --disable-sandbox

install: build
	install -d "$(bindir)" "$(libdir)"
	install ".build/release/one-wallpaper" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/one-wallpaper"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
