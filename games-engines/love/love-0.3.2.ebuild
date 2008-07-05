# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

DESCRIPTION="2D game engine which uses the versatile Lua scripting language"
HOMEPAGE="http://love.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV/.2/-2}.tar.bz2"

LICENSE="love"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/lua
	dev-libs/boost
	dev-games/physfs
	media-libs/devil
	media-libs/sdl-mixer"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	rm license.txt

	sed -i \
		-e "s|-g -O2 -Wall|${CFLAGS}|" \
		-e "s|-g0 -O3|${CFLAGS}|" \
		-e "s|-llua5.1|-llua|" \
		Makefile || die "sed failed"
}

src_compile() {
	emake -j1 || die "emake"
}

src_install() {
	dogamesbin bin/"${PN}"

	dodoc *.txt

	prepgamesdirs
}
