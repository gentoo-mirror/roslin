# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit cvs eutils games

DESCRIPTION="Kart racing"
HOMEPAGE="http://www.top10-racing.org/tiki-index.php"
#SRC_URI=""

ECVS_SERVER="cvs.savannah.nongnu.org:/sources/${PN}"
ECVS_MODULE="${PN}"
ECVS_LOCALNAME=${PN}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X debug editor"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

DEPEND="games-sports/top10-data
	media-libs/cal3d
	media-libs/lib3ds
	media-libs/openal
	>=media-libs/libsdl-1.2
	>=media-libs/plib-1.8.3
	>=media-libs/sdl-image-1.2.0
	>=sci-libs/cgal-3.2.1
	editor? ( >=x11-libs/qt-4.1.2 )"

RDEPEND="${DEPEND}"

src_compile() {
	./autogen.sh

	econf \
		$(use_with X x) \
		$(use_with debug) \
		$(use_enable editor tracked) \
		"--with-cgal-config=i686_Linux-2.6_i686-pc-linux-gnu-g++-4.1.2" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
#	emake DESTDIR=${D} install || die "emake failed"
	exeinto "${dir}"
	doexe src/ui_interactive/${PN} || die "doexe failed"

	games_make_wrapper ${PN} ./${PN} "${dir}" || die "gmw"

	dodoc *txt || die "dodoc failed"

	prepgamesdirs
}
