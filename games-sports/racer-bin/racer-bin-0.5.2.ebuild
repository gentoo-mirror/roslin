# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/games-sports/racer-bin/racer-bin-0.5.0-r1.ebuild,v 1.4 2004/05/04 02:19:04 mr_bones_ Exp $

inherit games

RESTRICT="nomirror"

DESCRIPTION="A car simulation game focusing on realism, in the style of Grand Prix Legends (beta5.3)"
HOMEPAGE="http://www.racer.nl/"
SRC_URI="http://gentoo.altervista.org/racer-bin/racer-0.5.2beta5.3.tar.bz2"
LICENSE="Racer"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/libsdl
	sys-libs/lib-compat"

S="${WORKDIR}/racer-${PV}"

src_compile() {
	einfo "Binary package. Nothing to compile"
}

src_install( ) {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	
	dodir ${dir} || die "dodir failed"

	
	cp -R ${S}/* "${D}/${dir}/" || die "cp failed"

	
	dodir ${GAMES_BINDIR}
	dosym ${dir}/racer ${GAMES_BINDIR}/racer

	prepgamesdirs
	
}
