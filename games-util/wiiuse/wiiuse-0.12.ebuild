# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games flag-o-matic

MY_P="${PN}_v${PV}_src"

DESCRIPTION="Library written in C that communicates with several Nintendo Wii remotes."
HOMEPAGE="http://wiiuse.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug examples sdl"

RDEPEND="net-wireless/bluez-utils
	examples? ( sdl? ( media-libs/libsdl ))"
DEPEND="${RDEPEND}
	sys-apps/sed"

S=${WORKDIR}/${MY_P/_src/}

src_unpack() {
	unpack ${A}
	cd ${S}
	
	epatch ${FILESDIR}/${P}-makefile.patch
	
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
	local opts=""
	# set default build target
	local bld="wiiuse"
	use examples && bld="${bld} ex"
	use sdl && bld="${bld} sdl-ex"
	
	use debug && opts="debug=1"
	opts="${opts} ${bld}"

	emake -j1 ${opts} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
}
