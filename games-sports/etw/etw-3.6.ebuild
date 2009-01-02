# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Arcade-style soccer game"
HOMEPAGE="http://etw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/ETW-${PV}-src.tar.gz
	mirror://sourceforge/${PN}/EatTheWhistle-linux-x86.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="media-libs/libsdl
	>=x11-libs/gtk+-1.2
	|| (
		(
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXext
			x11-libs/libXi )
		virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/sharutils"

dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	mv -f Makefile.linux Makefile
	mv "${WORKDIR}"/ETW/${PN} "${WORKDIR}"
	find "${WORKDIR}" '(' -name CVS -o -name .cvsignore -o -name .keepme ')' \
		| xargs rm -r
}

src_install() {
	newgamesbin ${PN} ${PN}.bin || die "dogamesbin failed"

	insinto "${dir}"
	doins -r "${WORKDIR}"/ETW/* || die "doins failed"

	games_make_wrapper "${PN}" "${GAMES_BINDIR}/${PN}.bin" "${dir}"
	make_desktop_entry ${PN} "Eat The Whistle"

	dodoc bugs.txt

	prepgamesdirs
}
