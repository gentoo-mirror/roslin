# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games eutils wxwidgets subversion games

ESVN_REPO_URI="http://svn.wildfiregames.com/public/ps/trunk"

DESCRIPTION="0 A.D. is a free, real-time strategy game currently under
development by Wildfire Games."
HOMEPAGE="http://wildfiregames.com/0ad/"

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/opengl
		dev-lang/spidermonkey[threadsafe]
		media-libs/openal
		dev-libs/crypto++
		media-libs/libsdl
		dev-libs/boost
		sys-libs/zlib
		|| ( dev-libs/libgamin app-admin/fam )
		dev-libs/xerces-c
		x11-libs/wxGTK:2.8
		media-libs/devil
		net-libs/enet
		media-video/ffmpeg
		media-libs/jpeg
		media-libs/libpng
		dev-libs/libxml2
		media-libs/libvorbis
		media-libs/libogg
		dev-util/valgrind"
DEPEND="${RDEPEND}
		dev-lang/nasm"

pkg_setup() {
	games_pkg_setup
	WX_GTK_VER=2.8 need-wxwidgets unicode
}

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	strip-flags

	cd "${S}/libraries/fcollada/src"
	emake || die "Can't build fcollada"
	cd "${S}/build/workspaces"
	./update-workspaces.sh
	cd gcc
#	sed -i "s:wx-config:${WX_CONFIG}:" AtlasUI.make || die "AtlasUI sed failed"
	emake || die "Can't build"
}
