# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils toolchain-funcs games

MY_P="${PN}_v${PV}_src"

DESCRIPTION="Library written in C that communicates with several Nintendo Wii remotes"
HOMEPAGE="http://wiiuse.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples"

DEPEND="net-wireless/bluez-utils"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P/_src/}

src_prepare() {
	epatch "${FILESDIR}/${P}-Makefile.patch"

	sed -i -e "s|/usr/lib|$(games_get_libdir)|" \
		src/Makefile || die "sed src/Makefile failed"
}

src_compile() {
	local opts

	use debug && opts="debug=1"

	emake CC=$(tc-getCC) ${opts} wiiuse || die "emake failed"
}

src_install() {
	local opts

	use debug && opts="debug=1"

	emake DESTDIR="${D}" ${opts} install || die "emake install failed"

	if use examples;
	then
		docinto examples/example
		dodoc example/{example.c,Makefile} || die

		docinto examples/example-sdl
		dodoc example-sdl/{sdl.c,Makefile} || die
	fi
}
