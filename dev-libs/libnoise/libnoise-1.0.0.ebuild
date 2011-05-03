# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit cmake-utils

DESCRIPTION="A portable coherent-noise-generating library for C++ compilers"
SRC_URI="mirror://sourceforge/libnoise/${P/ise/isesrc}.zip"
HOMEPAGE="http://sourceforge.net/projects/libnoise/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/noise

DEPEND=""
RDEPEND=""

src_prepare() {
	cp "${FILESDIR}/${PV}-cmake" "${S}/CMakeLists.txt"
}

src_install() {
	cmake-utils_src_install
}
