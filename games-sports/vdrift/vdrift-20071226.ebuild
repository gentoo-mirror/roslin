# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/vdrift/vdrift-20070323.ebuild,v 1.2 2007/08/01 18:40:28 angelos Exp $

inherit eutils toolchain-funcs games

MY_P=${PN}-${PV:0:4}-${PV:4:2}-${PV:6}
DESCRIPTION="A driving simulation made with drift racing in mind"
HOMEPAGE="http://vdrift.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.bz2
	mirror://sourceforge/${PN}/${MY_P}-data.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/freealut
	media-libs/libsdl
	media-libs/openal
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-net
	sci-physics/bullet
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.97
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack "${MY_P}-src.tar.bz2"
	cd "${S}"
	unpack "${MY_P}-data.zip"

	epatch ${FILESDIR}/${P}-scons-install.patch
}

src_compile() {
	tc-export CC CXX

	scons \
		NLS=$(use nls && echo 1 || echo 0) \
		destdir="${D}" \
		bindir="${GAMES_BINDIR}" \
		datadir="${GAMES_DATADIR}"/${PN} \
		localedir=/usr/share/locale \
		prefix= \
		use_binreloc=0 \
		release=1 \
		os_cc=1 \
		os_cxx=1 \
		os_cxxflags=1 \
		|| die "scons failed"
}

src_install() {
	scons install || die "scons install failed"
#	dogamesbin build/${PN}

	newicon data/textures/icons/vdrift-64x64.png ${PN}.png
	make_desktop_entry ${PN} VDrift
	
	dodoc docs/*

#	insinto "${GAMES_DATADIR}/${PN}"
#	rm \
#		data/README \
#		data/SCons* \
#		data/*/SCons* \
#		data/*/*/SCons* \
#		data/*/*/*/SCons* \
#		|| die "rm failed"

#	doins -r \
#		data/* \
#		|| die "doins failed"
		
	prepgamesdirs
}
