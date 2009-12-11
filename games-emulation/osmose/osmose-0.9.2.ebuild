# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

MY_PV="${PV//./-}"
MY_PV="${MY_PV/b/beta}"

DESCRIPTION="Osmose is a GPL'd Sega Master System/Gamegear emulator"
HOMEPAGE="http://bcz.emu-france.com/"
SRC_URI="http://bcz.emu-france.com/${PN}/Osmose-${MY_PV}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[opengl,joystick]
	sys-libs/zlib
	virtual/opengl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Osmose-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install() {
	dogamesbin ${PN}

	dodoc changes.txt readme.txt
	make_desktop_entry ${PN}

	prepgamesdirs
}
