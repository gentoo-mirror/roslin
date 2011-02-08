# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author: Michał "mziab" Ziąbkowski
# Base eclass for modular Kadu ebuilds

inherit eutils flag-o-matic cmake-utils

LICENSE="GPL-2"
SLOT="0"
RESTRICT="primaryuri"
IUSE="debug"

# If no version was requested, default to this one
MIN_VER="${MIN_VER:-0.6.5.4}"

K_PV="${PV/_p/.}"
K_PV="${K_PV/_/-}"

NAME="${PN#*-}"

if [ "${K_PV:0:5}" == "0.6.6" ]; then
	S="${WORKDIR}/kadu-${K_PV}"
else
	S="${WORKDIR}/kadu"
fi

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
	append-cflags -DQT_NO_DEBUG -Wno-error

	use debug && local CMAKE_BUILD_TYPE="debug"

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

case ${EAPI} in
    2)
	EXPORT_FUNCTIONS src_configure src_compile
	;;
    *)
	EXPORT_FUNCTIONS src_compile
	;;
esac
