# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.2.ebuild,v 1.3 2004/11/22 20:37:06 plasmaroo Exp $

EAPI=2

inherit confutils games cmake-utils subversion

ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/"
ESVN_PROJECT="vbam"

DESCRIPTION="A VBA fork that focuses on consolidating existing ports and improving VBA in general"
HOMEPAGE="http://vba-m.ngemu.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk lirc sdl"

RDEPEND="gtk? ( >=dev-cpp/libglademm-2.4.0
		>=dev-cpp/glibmm-2.4.0
		>=dev-cpp/gtkmm-2.4.0
		>=media-libs/portaudio-19_pre
		x11-libs/libXv
		>=dev-cpp/gtkglextmm-1.2.0 )
		media-libs/libpng
		sys-libs/zlib
		media-libs/libsdl[joystick]
		lirc? ( app-misc/lirc )
		virtual/opengl"

DEPEND="${RDEPEND}
		dev-lang/nasm
		>=dev-util/cmake-2.4.0
		dev-util/pkgconfig"

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

	epatch "${FILESDIR}"/${PN}-includes-fix.patch
}

src_configure() {
	mycmakeargs="$(cmake-utils_use_no sdl SDL)
	$(cmake-utils_use_no gtk GTK)
	$(cmake-utils_use_with lirc LIRC)
	-DCMAKE_INSTALL_PREFIX:PATH='${GAMES_PREFIX}'
	-DDATA_INSTALL_DIR:PATH='${GAMES_DATADIR}/${PN}'"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doman debian/${PN}.1

	prepgamesdirs
}
