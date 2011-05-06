# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="Another Free Warlords II clone"
HOMEPAGE="http://www.lordsawar.com/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="editor nls pbm sound zip"

RDEPEND="dev-libs/boost
	nls? ( sys-devel/gettext )
	>=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	media-libs/sdl-image
	media-libs/sdl-mixer
	sound? ( media-libs/sdl-mixer[vorbis] )
	>=net-libs/gnet-2
	>=dev-libs/libsigc++-2
	>=dev-libs/expat-2.0
	dev-libs/libtar"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_pre*/}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-sdltest \
		$(use_enable editor) \
		$(use_enable nls) \
		$(use_enable pbm) \
		$(use_enable sound) \
		$(use_enable zip zipping) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}"/usr/share/locale/locale.alias
	doicon dat/various/${PN}.png
	make_desktop_entry ${PN} LordsAWar
	if use editor ; then
		doicon dat/various/${PN}_editor.png
		make_desktop_entry ${PN}_editor "LordsAWar Editor" ${PN}_editor
	fi
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	prepgamesdirs
}
