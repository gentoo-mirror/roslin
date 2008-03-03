# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Nil isn't Liero (Liero clone)"
HOMEPAGE="http://nil.sourceforge.net/"
SRC_URI="mirror://sourceforge/nil/${PN}-cvs-backup-${PV/./-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/x11
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-ttf-2.0.5
	>=sys-apps/sed-4
	media-libs/freetype
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-lang/python"
S=${WORKDIR}/${PN}/${PN}


src_compile() {
	sed -i -e 's,~/nil/gfx/,/usr/share/games/nil/,g' \
		   -e  's,\"640x480\",\"1024x768\",g' nil/configuration.cpp || die "sed failed."
	egamesconf || die "egamesconf failed."
	emake || die "emake failed."
}

src_install() {
	egamesinstall || die "emake install failed."
	mkdir -p  ${D}/${GAMES_DATADIR}/${PN} || die "mkdir failed."
	cd ..
	cp -r   gfx/{original,ripped} ${D}/${GAMES_DATADIR}/${PN}/  || die "cp failed."
	dodoc docs/{NiL-HOWTO.txt,TODO} AUTHORS COPYING README ChangeLog  || die "dodoc failed."
	prepgamesdirs
}
