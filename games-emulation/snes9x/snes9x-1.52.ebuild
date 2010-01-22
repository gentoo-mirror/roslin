# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="Super Nintendo Entertainment System (SNES) emulator"
HOMEPAGE="http://www.snes9x.com/"
SRC_URI="http://snes9x-gtk.googlecode.com/files/${P}-src.tar.bz2"

LICENSE="as-is GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug joystick jma netplay zlib"

RDEPEND="x11-libs/libXext
	x11-libs/libSM
	x11-libs/libICE
	media-libs/libpng
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}-src/unix"

src_configure() {
	egamesconf \
		$(use_enable joystick gamepad) \
		$(use_enable debug debugger) \
		$(use_enable jma) \
		$(use_enable zlib gzip) \
		$(use_enable netplay) \
		|| die
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"
	dohtml docs/readme_unix.html
	dodoc ../docs/*
	prepgamesdirs
}
