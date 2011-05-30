# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author: Michał "mziab" Ziąbkowski
# Base eclass for modular Kadu ebuilds

inherit base flag-o-matic cmake-utils

LICENSE="GPL-2"
SLOT="0"
RESTRICT="primaryuri"
IUSE="debug"

K_PV="${PV/_p/.}"
K_PV="${K_PV/_/-}"

SRC_URI="http://kadu.net/download/unstable/kadu-${K_PV}.tar.bz2"

NAME="${PN#*-}"

S="${WORKDIR}/kadu-${K_PV}"

if [ "${NAME}" != "core" ]; then
	S="${S}/plugins/${NAME}"
fi

kadu_src_configure() {
	# Filter compiler flags
	filter-flags -fno-rtti

	use debug && local CMAKE_BUILD_TYPE="debug"

	local mycmakeargs="${mycmakeargs} \
		-DBUILD_DESCRIPTION:STRING='Gentoo Linux' \
		-DENABLE_AUTODOWNLOAD:BOOL=OFF"

	cmake-utils_src_configure
}

kadu_src_compile() {
	case ${EAPI:-0} in
	0|1) kadu_src_configure ;;
	esac

	cmake-utils_src_compile
}

case ${EAPI:-0} in
	0|1) EXPORT_FUNCTIONS src_compile ;;
    2|3) EXPORT_FUNCTIONS src_configure src_compile ;;
    *) die "no support for EAPI=${EAPI}" ;;
esac
