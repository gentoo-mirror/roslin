# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils autotools games

DESCRIPTION="Space-flying-mushroom-picking-simulator"
HOMEPAGE="http://funguloids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-linux-${PV}.tar.bz2"

# See COPYING for details
LICENSE="zlib/libpng"
SLOT="0"
KEYWORDS="~x86"
IUSE="fmodex mad ogg"

RDEPEND="dev-games/ogre[cg,devil]
	>=dev-games/ois-1.0
	fmodex? ( >=media-libs/fmodex-4.06.16 )
	mad? ( >=media-libs/openal-1.5.304
		media-libs/libmad )
	ogg? ( >=media-libs/openal-1.5.304
		media-libs/libvorbis )
	media-libs/freealut
	dev-lang/lua"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_prepare() {
	sed -i \
		-e "s:bininstalldir="${prefix}/games":bininstalldir="${prefix}/bin":" \
		-e "s:-llua5.1:-llua:" configure || die "sed failed"
	sed -i \
		-e "s:bininstalldir="${prefix}/games":bininstalldir="${prefix}/bin":" \
		-e "s:-llua5.1:-llua:" configure.ac || die "sed failed"
		
	epatch "${FILESDIR}/${PN}-ogre-fix.patch"
	epatch "${FILESDIR}/${PN}-alc_error.patch"
		
	eautoreconf
}

src_compile() {
	econf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin bin/${PN} || die "installing the binary failed"

	insinto "${dir}"
	rm -r bin/docs
	rm bin/music/Makefile* bin/music/playlist.lua.in

	if use ogg ; then
		doins -r bin/music
	fi

	doins bin/icon bin/*.cfg bin/*.mpk

	dodoc INSTALL README

	prepgamesdirs
}
