# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

MY_PV="${PV//./-}"

DESCRIPTION="Osmose is a GPL'd Sega Master System/Gamegear emulator"
HOMEPAGE=""
SRC_URI="http://bcz.emu-france.com/${PN}/Osmose${MY_PV}-source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl[opengl]
	sys-libs/zlib
	virtual/opengl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Osmose-${MY_PV}-source"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${PN}-makefile.patch"
}

src_install() {
	dogamesbin ${PN}

	dodoc changes.txt readme.txt

	prepgamesdirs
}
