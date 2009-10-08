# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="A Gens fork which aims to clean up the source code and combine features from other forks"
HOMEPAGE="http://info.sonicretro.org/Gens/GS"
SRC_URI="http://info.sonicretro.org/images/1/19/Gens-gs-r${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="opengl"

DEPEND="opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2[opengl?]
	x11-libs/gtk+:2
	virtual/libiconv
	!games-emulation/gens"
RDEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

S="${WORKDIR}/${PN}-r${PV}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS.txt ChangeLog.txt NEWS.txt README.txt
	prepgamesdirs
}

src_compile() {
	egamesconf $(use_with opengl) || die "econf failed"
	emake || die "emake failed"
}
