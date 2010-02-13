# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author: Michał "mziab" Ziąbkowski
# Base eclass for modular Kadu ebuilds

inherit eutils flag-o-matic cmake-utils

LICENSE="GPL-2"
SLOT="0"
RESTRICT="primaryuri"

# If no version was requested, default to this one
MIN_VER="${MIN_VER:-0.6.5.3}"

K_PV="${PV/_p/-}"
K_PV="${K_PV/_/-}"

NAME="${PN#*-}"

S="${WORKDIR}/kadu"

kadu-disable_all() {
	# Disable all modules, emoticons, icons and sounds
	# so we have a clean state
	sed -e "s:^\(.*\)=[my]$:\1=n:g" \
	    -i .config || die "sed failed"
}

kadu-base_src_configure() {
	# Filter compiler flags
	filter-flags -fno-rtti

	# Fix some versions of cmake-utils.eclass
	# which set CMAKE_BUILD_TYPE to Gentoo
	append-cppflags -DQT_NO_DEBUG

	local mycmakeargs="${mycmakeargs} \
		-DBUILD_DESCRIPTION:STRING='Gentoo Linux' \
		-DENABLE_AUTDOWNLOAD:BOOL=NO"

	cmake-utils_src_configure
}

kadu-base_src_compile() {
	case ${EAPI} in
	2)
		;;
	*)
		kadu-base_src_configure
		;;
	esac

	cmake-utils_src_compile
}

kadu-base_src_install() {
	cmake-utils_src_install

	# if not core, delete docs
	[ "${NAME}" != "core" ] && rm -f \
	${D}/usr/share/kadu/{AUTHORS,COPYING,ChangeLog,HISTORY,README,THANKS}
}

case ${EAPI} in
    2)
	EXPORT_FUNCTIONS src_configure src_compile src_install
	;;
    *)
	EXPORT_FUNCTIONS src_compile src_install
	;;
esac
