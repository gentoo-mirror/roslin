# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit libtool multilib eutils

DESCRIPTION="pnglite is a C library for loading PNG images"
HOMEPAGE="http://www.karlings.com/~danne/pnglite/"
SRC_URI="mirror://sourceforge/pnglite/pnglite-${PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${PN}-${PV}-system_zlib.patch
	epatch "${FILESDIR}"/${PN}-${PV}-include_stdio.patch
	cp -f "${FILESDIR}/${PV}-Makefile" "${WORKDIR}/Makefile" || die
	sed -i -e "s/\%CFLAGS\%/${CFLAGS}/" -e "s/\%LDFLAGS\%/${LDFLAGS}/" "${WORKDIR}/Makefile"
}

src_install() {
	dolib libpnglite.so.0.1
	cd  "${D}"/usr/$(get_libdir)
	ln -s libpnglite.so.0.1 libpnglite.so

	dodir /usr/include
	insinto /usr/include
	doins "${WORKDIR}/pnglite.h"
}
