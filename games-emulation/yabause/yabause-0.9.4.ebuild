# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.9.3.ebuild,v 1.1 2008/01/20 22:26:28 mr_bones_ Exp $

inherit autotools games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-2*
	x11-libs/gtkglext
	virtual/opengl
	virtual/glu
	virtual/glut
	media-libs/libsdl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(datadir):/usr/share:' \
		src/gtk/Makefile.am \
		|| die "sed failed"
		
	eautoreconf
}

src_compile() {
	cd ${S}
	
	# I know this is ugly, but configure magic drove me up the wall
	egamesconf --host="" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# 
	emake DESTDIR="${D}" install || die "emake install failed"
	
	# hackish fix for some bad directory structure
	mv ${D}/usr/local/share ${D}/usr/games/share
	rm -rf ${D}/usr/local
	
	dodoc AUTHORS ChangeLog GOALS README README.LIN TODO
	prepgamesdirs
}
