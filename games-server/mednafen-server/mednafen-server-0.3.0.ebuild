# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.8.1.ebuild,v 1.1 2007/07/04 01:25:10 mr_bones_ Exp $

inherit autotools games

DESCRIPTION="Server for Mednafen emulator"
HOMEPAGE="http://mednafen.sourceforge.net/"
SRC_URI="mirror://sourceforge/mednafen/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gcc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s|CFLAGS  =       -g|CFLAGS = ${CFLAGS}|" \
		Makefile || die "sed"
	mv standard.conf standard.conf.example
	mv run.sh run.sh.example
}

src_install() {
	dodoc README *.example
	dobin ${PN}
	prepgamesdirs
}

pkg_postinst() {
	einfo ""
	einfo "Example config file and run file can be found in"
	einfo "/usr/share/doc/${P}/"
	einfo ""
}
