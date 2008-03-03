# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs games

DESCRIPTION="Educational tool to simulate car crashes"
HOMEPAGE="http://stolk.org/crashtest/"
SRC_URI="http://stolk.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# See INSTALL file for dependencies.
RDEPEND=">=x11-libs/fltk-1.1
	>=dev-games/ode-0.6
	>=media-libs/plib-1.8.4
	media-libs/alsa-lib
	virtual/opengl
	virtual/glu
	virtual/glut"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/src-${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:/usr/share/games/${PN}:${GAMES_DATADIR}/${PN}:" \
		-e "s:<FL/:<fltk-$(fltk-config --api-version)/FL/:" \
		${PN}.cxx || die "sed ${PN}.cxx failed"

	sed -i \
		-e "s:/usr/games:${GAMES_BINDIR}:" \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	emake \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS} -I../src-common" \
		LFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		GAMEDIR="${D}/${GAMES_DATADIR}/${PN}" \
		install || die "emake install failed"

	make_desktop_entry ${PN} "Crash Test"

	dodoc README

	prepgamesdirs
}
