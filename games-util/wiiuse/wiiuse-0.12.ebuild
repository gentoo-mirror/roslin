# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic games

MY_P="${PN}_v${PV}_src"

DESCRIPTION="Library written in C that communicates with several Nintendo Wii remotes."
HOMEPAGE="http://wiiuse.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug examples"

RDEPEND="net-wireless/bluez-utils
	examples? ( media-libs/libsdl
		virtual/glut )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P/_src/}

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"

	# -fomit-frame-pointer shouldn't be used with USE="debug"
	use debug && filter-flags "-fomit-frame-pointer"

	sed -i \
		-e "s|-Wall -pipe -fPIC -funroll-loops|${CFLAGS} -fPIC|" \
		-e "s|/usr/lib|`games_get_libdir`|" \
		src/Makefile || die "sed src/Makefile failed"

	sed -i \
		-e "s|CFLAGS = -Wall -pipe -fPIC -funroll-loops|CFLAGS = ${CFLAGS} -fPIC|" \
		-e "s|/usr/bin|${GAMES_BINDIR}|" \
		example/Makefile example-sdl/Makefile || die "sed failed"
}

src_compile() {
	# set default build target
	local opts="wiiuse"
	use examples && opts="${opts} ex sdl-ex"
	use debug && opts="debug=1 ${opts}"
	opts="${opts} ${bld}"

	emake ${opts} || die "emake failed"
}

src_install() {
	local instopts
	use debug && instopts="debug=1"
	emake DESTDIR="${D}" ${instopts} install || die "einstall failed"
}
