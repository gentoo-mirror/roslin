# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.2.ebuild,v 1.3 2004/11/22 20:37:06 plasmaroo Exp $

inherit games subversion

#ESVN_REPO_URI="http://svn.bountysource.com/vbam/trunk/"
ESVN_REPO_URI="http://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/"
ESVN_PROJECT="vbam"

DESCRIPTION="A VBA fork that focuses on consolidating existing ports and improving VBA in general"
HOMEPAGE="http://vba-m.ngemu.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gtk sdl"

RDEPEND="gtk? ( >=dev-cpp/libglademm-2.4.0
		>=dev-cpp/glibmm-2.4.0
		>=dev-cpp/gtkmm-2.4.0
		>media-libs/portaudio-18.2
		x11-libs/libXv)
		!games-emulation/visualboyadvance
		media-libs/libpng
		sys-libs/zlib
		sdl? ( media-libs/libsdl )
		virtual/opengl"

DEPEND="${RDEPEND}
		dev-util/cmake
		dev-util/pkgconfig"
		

S="${WORKDIR}/${PN}"

pkg_setup() {
	if ! use sdl && ! use gtk; then
	    die "You have to enable USE gtk or sdl, or both"
	fi
}

src_unpack() {
	subversion_src_unpack
	cd ${S}
	
	epatch "${FILESDIR}/${PN}-cmake.patch"
	sed -i CMakeLists.txt \
	    -e "s:GAMES_DATADIR:${GAMES_DATADIR}:" \
	    || die "sed failed"
}

src_compile() {
	cmake \
	-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}" \
	-DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
	-DCMAKE_C_FLAGS="${CFLAGS}" \
	-DDATA_INSTALL_DIR="${GAMES_DATADIR}" \
	. || die "cmake failed"

	emake || die "emake failed"
}

src_install() {
	#emake DESTDIR="${D}" PREFIX="${GAMES_PREFIX}" install || die "make install failed"
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{DevInfo,ReadMe}.txt
	
	prepgamesdirs
}
