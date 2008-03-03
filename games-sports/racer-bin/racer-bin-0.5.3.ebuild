# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/games-sports/racer-bin/racer-bin-0.5.0-r1.ebuild,v 1.4 2004/05/04 02:19:04 mr_bones_ Exp $

inherit games

RESTRICT="nomirror"

DESCRIPTION="A car simulation game focusing on realism, in the style of Grand Prix Legends (beta5.3)"
HOMEPAGE="http://www.racer.nl/"
SRC_URI="http://racer.nl/download/racer053b5.zip
	http://racer.nl/download/linux/racer053b6test.zip"
LICENSE="Racer"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/fmodex"

S="${WORKDIR}/racer053b5"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/racer053b6test/* ${WORKDIR}/racer053b5/
}

src_compile() {
	einfo "Binary package. Nothing to compile"
}

src_install( ) {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	
	dodir ${dir} || die "dodir failed"

	cd ${S}
	rm *.dll *.exe || die "rm failed"

	insinto ${dir}
	insopts -m0644
	doins -r data *.ini racer.*
	exeinto ${dir}
	doexe racer

	dodir ${GAMES_BINDIR}
#	dosym ${dir}/racer ${GAMES_BINDIR}/racer
	games_make_wrapper racer ./racer ${dir}
	dosym /usr/lib/libfmodex.so ${dir}/libfmodex.so

	prepgamesdirs	
}
