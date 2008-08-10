# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="${PN}_v${PV}_src"

DESCRIPTION="Library written in C that communicates with several Nintendo Wii remotes."
HOMEPAGE="http://wiiuse.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="net-wireless/bluez-utils"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s|-Wall -pipe -fPIC -funroll-loops|${CFLAGS} -fPIC|" \
		src/Makefile || die "sed src/Makefile failed"

	sed -i \
		-e "s|CFLAGS = -Wall -pipe|CFLAGS = ${CFLAGS}|" \
		api/Makefile || die "sed api/Makefile failed"

	sed -i \
		-e "s|CFLAGS = -Wall -pipe|CFLAGS = ${CFLAGS}|" \
		gfx/Makefile || die "sed gfx/Makefile failed"

#	epatch ${FILESDIR}/${P}-gfx.c.patch
}

src_compile() {
	# build lib
	cd src
	emake || die "emake1 failed"

	# build example
	cd ../api
	emake || die "emake2 failed"

	# build graphical example
	cd ../gfx
	emake || die "emake3 failed"
}

src_install() {
	dolib src/${PN}.so

	dobin api/${PN}-example gfx/${PN}-gfx

	dodoc CHANGELOG README
}
