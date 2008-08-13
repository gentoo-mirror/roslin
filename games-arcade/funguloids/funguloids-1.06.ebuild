# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Space-flying-mushroom-picking-simulator"
HOMEPAGE="http://funguloids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-linux-${PV}.tar.bz2"

# See COPYING for details
LICENSE="zlib/libpng"
SLOT="0"
KEYWORDS="~x86"
IUSE="fmodex mad ogg"

RDEPEND=">=dev-games/ogre-1.4.1
	>=dev-games/ois-1.0
	fmodex? ( >=media-libs/fmodex-4.06.16 )
	mad? ( media-libs/openal
		media-libs/libmad )
	ogg? ( media-libs/openal
		media-libs/libvorbis )
	media-libs/freealut
	dev-lang/lua"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

pkg_setup() {
	if ! built_with_use dev-games/ogre cg && ! built_with_use \
		dev-games/ogre devil ; then
			einfo "Please rebuild ogre with USE=\"cg devil\""
			die "dev-games/ogre missing cg or devil support"
	fi
}

src_unpack() {
	unpack ${PN}-linux-${PV}.tar.bz2
	cd "${S}"

	sed -i \
		-e "s:bininstalldir="${prefix}/games":bininstalldir="${prefix}/bin":" \
		-e "s:-llua5.1:-llua:" configure || die "sed failed"
	sed -i \
		-e "s:bininstalldir="${prefix}/games":bininstalldir="${prefix}/bin":" \
		-e "s:-llua5.1:-llua:" configure.ac || die "sed failed"
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
