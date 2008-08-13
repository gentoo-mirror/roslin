# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games subversion cmake-utils

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
ESVN_REPO_URI="http://supertux.lethargik.org/svn/supertux/trunk/supertux"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.2
	sys-libs/zlib
	>=dev-games/physfs-1.0.0
	media-libs/libvorbis
	media-libs/libogg
	media-libs/openal"
DEPEND="${RDEPEND}
	x11-libs/libXt"

S=${WORKDIR}/${PN}

pkg_setup() {
	games_pkg_setup
}

src_unpack() {
	subversion_src_unpack
	cd "${S}"

	epatch "${FILESDIR}"/"${P}-cmakelists.patch"
}

src_compile() {
	cmake-utils_src_configurein || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README
	prepgamesdirs
}
