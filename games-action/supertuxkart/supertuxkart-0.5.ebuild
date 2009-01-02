# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="A kart racing game starring Tux, the linux penguin (TuxKart fork)"
HOMEPAGE="http://supertuxkart.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/plib-1.8.4
	virtual/opengl
	media-libs/libmikmod
	media-libs/libvorbis
	media-libs/openal
	media-libs/freealut
	media-libs/libsdl"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR_BASE}" \
			|| die "configuration failed"
	emake || die "emake failed"
}

src_install() {
	#data install
	dodir "/${GAMES_DATADIR}/${PN}/data"
	insinto "/${GAMES_DATADIR}/${PN}/data"
	doins -r data/*

	#doc install
	cd "${S}"/doc/players_manual/
	rm Makefile*
	dodir "/${GAMES_DATADIR_BASE}/doc/${P}"
	insinto "/${GAMES_DATADIR_BASE}/doc/${P}"
	doins ./*

	#binary install
	cd "${S}"
	dogamesbin src/"${PN}"

	doicon "${DISTDIR}/${PN}.png"
	make_desktop_entry "${PN}" SuperTuxKart
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
