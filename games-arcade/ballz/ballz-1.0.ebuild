# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="A platformer with some puzzle elements."
HOMEPAGE="http://darkbits.org/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/allegro"

DEPEND="${RDEPEND}"

src_compile() {
	egamesconf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/${PN} || die "installing the binary failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* || die "installing data failed"
	dodoc *-license AUTHORS ChangeLog INSTALL NEWS README || die "installing docs failed"

	prepgamesdirs
}
