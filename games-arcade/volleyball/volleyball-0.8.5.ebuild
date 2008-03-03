# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DATA_PV=0.8.4
DATA_PN=${PN}-data
DESCRIPTION="A simple sport game, similar to GNU Arcade Volleyball"
HOMEPAGE="http://www.losersjuegos.com.ar/juegos/volleyball/volleyball.php"
SRC_URI="http://www.loosersjuegos.com.ar/juegos/volleyball/descargas/${P}.tar.gz
	http://www.loosersjuegos.com.ar/juegos/volleyball/descargas/${DATA_PN}-${DATA_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND="media-libs/libsdl"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
	cd "${WORKDIR}/${DATA_PN}-${DATA_PV}"
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	cd "${WORKDIR}/${DATA_PN}-${DATA_PV}"
	emake DESTDIR="${D}" install || die "emake install failed"
	make_desktop_entry volleyball Volleyball
	prepgamesdirs
}
