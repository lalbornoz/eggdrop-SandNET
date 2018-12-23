#!/bin/sh

main() {
	rm -rf "build_SandNET";						\
	mkdir "build_SandNET"						&&\
	cd "build_SandNET"						&&\
	env CFLGS="-DCAN_REGEX_BANS -DCAN_SCROLL"			\
	../configure							\
		--prefix=${HOME}/TclBint				\
		--with-tcl=/usr/lib/tcl8.4				&&\
	make config all;
};

set -o errexit -o noglob; main "${@}";
