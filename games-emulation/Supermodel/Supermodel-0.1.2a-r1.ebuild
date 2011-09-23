# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

MY_P="${PN}_${PV}_Src"

DESCRIPTION="A Sega Model 3 Arcade Emulator"
HOMEPAGE="http://www.trzy.org/Supermodel/"
SRC_URI="http://www.trzy.org/Supermodel/Files/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/glew
	sys-libs/zlib[minizip]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	ln -s Makefiles/Makefile.SDL.UNIX.GCC Makefile
	epatch "${FILESDIR}"/${PN}-unbundle-libs.patch
}

src_install() {
	dogamesbin ${PN} || die
	dodoc README.txt || die
}
