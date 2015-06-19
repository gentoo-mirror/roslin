# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Adds stencil shadows and per pixel lights to Quake"
HOMEPAGE="http://tenebrae.sourceforge.net/"
SRC_URI="mirror://sourceforge/tenebrae/tenebraedata.zip
	mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libpng
	x11-libs/libXxf86vm
	x11-libs/libXxf86dga"
#	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	app-arch/unzip"

S=${WORKDIR}/tenebrae_0

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${PV}-glhax.patch" \
		"${FILESDIR}/${P}-exec-stack.patch" \
		"${FILESDIR}/${P}-worldangles.patch" \
		"${FILESDIR}/${P}-bsd-stuff.patch"
	cd linux
	sed "s:-mpentiumpro -O6:${CFLAGS}:" Makefile.i386linux > Makefile
}

src_compile() {
	cd "${S}"/linux
	emake MASTER_DIR="${GAMES_DATADIR}/quake1" build_release || die "emake failed"
}

src_install() {
	newgamesbin linux/release*/bin/tenebrae.run tenebrae || die "newgamesbin"
	insinto "${GAMES_DATADIR}/quake1/tenebrae"
	doins "${WORKDIR}"/tenebrae/* || die "doins data"
	dodoc linux/README "${WORKDIR}"/Tenebrae_Readme.txt || die "dodoc failed"
	prepgamesdirs
}
