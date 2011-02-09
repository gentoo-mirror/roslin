# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9x/snes9x-1.52-r1.ebuild,v 1.10 2010/11/15 09:49:52 tupone Exp $

EAPI=2

inherit eutils autotools git

DESCRIPTION="libsnes implementation utilizing the snes9x core"
HOMEPAGE="https://github.com/Themaister/snes9x-libsnes/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/snes9x-libsnes.git"

LICENSE="as-is GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""

DEPEND="!dev-games/libsnes"

S="${WORKDIR}/${P}/unix"

src_unpack() {
	S="${WORKDIR}/${P}" git_fetch
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-build.patch"
	eautoreconf
}

src_install() {
	dolib.so libsnes.so || die
	dolib.a libsnes.a || die

	sed -e "/port.h/d" \
		-i libsnes.hpp \
		|| die

	insinto /usr/include
	doins libsnes.hpp || die
}
