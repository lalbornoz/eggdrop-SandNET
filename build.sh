#!/bin/sh

configure_EFnet() {
	local _prefix="${1}";
	../configure							\
		--prefix="${_prefix}"					\
		--with-tcl=/usr/lib/tcl8.6;
};

configure_SandNET() {
	local _prefix="${1}";
	env CFLGS="-DCAN_REGEX_BANS -DCAN_SCROLL"			\
	../configure							\
		--prefix="${_prefix}"					\
		--with-tcl=/usr/lib/tcl8.4;
};

mkdir() {
	while [ ${#} -gt 0 ]; do
		rm -fr "${1}"; command mkdir -p "${1}"; shift;
	done;
};

main() {
	local _build_dname="" _dest_dname="" _dest_dname_binary=""	\
		_dest_dname_modules="" _git_commit="" _network_name="";

	_network_name="${1}"; shift;
	_git_commit="$(git rev-parse --short HEAD)";

	_build_dname="build_${_network_name}";
	_dest_dname="${HOME}/TclBint";
	_dest_dname_binary="${_dest_dname}/eggdrop.${_network_name}-${_git_commit}";
	_dest_dname_modules="${_dest_dname}/modules.${_network_name}-${_git_commit}";

	mkdir "${_build_dname}"; cd "${_build_dname}";
	"configure_${_network_name}" "${_dest_dname}";
	make config all;
	mkdir "${_dest_dname_modules}";
	set +o noglob; cp -a *.so "${_dest_dname_modules}/"; set -o noglob;
	cp -a eggdrop "${_dest_dname_binary}";
};

set -o errexit -o noglob -o nounset; main "${@}";
