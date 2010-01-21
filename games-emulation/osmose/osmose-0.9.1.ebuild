# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

MY_P="Osmose-${PV//./-}"

DESCRIPTION="Osmose is a GPL'd Sega Master System/Gamegear emulator"
HOMEPAGE="http://bcz.emu-france.com/"
SRC_URI="http://bcz.emu-france.com/${PN}/${MY_P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[opengl,joystick]
	sys-libs/zlib
	virtual/opengl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install() {
	dogamesbin ${PN} || die "dobin failed"
	dodoc changes.txt readme.txt
	prepgamesdirs
}
