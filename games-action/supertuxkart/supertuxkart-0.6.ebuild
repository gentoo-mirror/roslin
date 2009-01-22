# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="A kart racing game starring Tux, the linux penguin (TuxKart fork)"
HOMEPAGE="http://supertuxkart.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~x86"
KEYWORDS=""
IUSE="debug nls"

DEPEND=">=media-libs/plib-1.8.4
	virtual/opengl
	media-libs/libvorbis
	media-libs/openal
	media-libs/libsdl"

src_prepare() {
	epatch "${FILESDIR}"/"${PV}"-Makefile.patch
}

src_configure() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		$(use_enable debug) \
		$(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	#data install
#	dodir "/${GAMES_DATADIR}/${PN}/data"
#	insinto "/${GAMES_DATADIR}/${PN}/data"
#	doins -r data/* || die "doins failed"

	#doc install
#	cd "${S}"/doc/players_manual/
#	rm Makefile*
#	dodir "/${GAMES_DATADIR_BASE}/doc/${P}"
#	insinto "/${GAMES_DATADIR_BASE}/doc/${P}"
#	doins ./* || die "doins failed"

	#binary install
#	cd "${S}"
#	dogamesbin src/supertuxkart || die "dogamesbin failed"

#	doicon "${DISTDIR}"/"${PN}".png
#	make_desktop_entry "${PN}" SuperTuxKart
#	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
	prepgamesdirs
}
