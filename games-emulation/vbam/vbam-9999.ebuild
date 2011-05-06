# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.2.ebuild,v 1.3 2004/11/22 20:37:06 plasmaroo Exp $

EAPI=2

ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/"
ESVN_PROJECT="vbam"

inherit confutils games cmake-utils subversion

DESCRIPTION="A VBA fork that focuses on consolidating existing ports and improving VBA in general"
HOMEPAGE="http://vba-m.ngemu.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gbalink gtk lirc nls sdl"

RDEPEND="gtk? ( >=dev-cpp/libglademm-2.4.0
	>=dev-cpp/glibmm-2.4.0:2
	>=dev-cpp/gtkmm-2.4.0:2.4
	>=media-libs/portaudio-19_pre
	x11-libs/libXv
	>=dev-cpp/gtkglextmm-1.2.0 )
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl[joystick]
	gbalink? ( media-libs/libsfml )
	lirc? ( app-misc/lirc )
	virtual/opengl"

DEPEND="${RDEPEND}
	dev-lang/nasm
	>=dev-util/cmake-2.4.0
	gtk? ( dev-util/pkgconfig
	sys-devel/gettext )"

S="${WORKDIR}/${PN}"

DOCS="doc/DevInfo.txt doc/ReadMe.SDL.txt"

pkg_setup() {
	confutils_require_any sdl gtk
}

src_prepare() {
	sed -i CMakeLists.txt \
	    -e "/C[X]*_FLAGS/d" \
	    -e "s:\${CMAKE_INSTALL_PREFIX}/::" \
	    -e "s: share: ../share:g" \
	    	    || die "sed failed"
}

src_configure() {
	mycmakeargs="$(cmake-utils_use_no sdl SDL)
	$(cmake-utils_use_enable gtk GTK)
	$(cmake-utils_use_enable lirc LIRC)
	$(cmake-utils_use_enable nls NLS)
	$(cmake-utils_use_enable gbalink LINK)
	-DCMAKE_INSTALL_PREFIX:PATH='${GAMES_PREFIX}'
	-DDATA_INSTALL_DIR:PATH='${GAMES_DATADIR}/${PN}'"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doman debian/${PN}.1

	prepgamesdirs
}
