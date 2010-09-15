# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="Side-scrolling beat-em-up in the style of Beats of Rage"
HOMEPAGE="http://paintown.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/allegro-4.1
	media-libs/aldumb
	media-libs/freetype
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/cmake"

dir=${GAMES_DATADIR}/${PN}

src_install() {
	emake DESTDIR="${D}" install || die
#	dogamesbin ../${P}_build/bin/${PN} || die "dogamesbin failed"

#	insinto "${dir}"
#	doins -r data/* || die "doins failed"

#	make_desktop_entry ${PN} Paintown

#	dodoc "${WORKDIR}/${P}"/{README,TODO} || die "dodoc failed"

	prepgamesdirs
}