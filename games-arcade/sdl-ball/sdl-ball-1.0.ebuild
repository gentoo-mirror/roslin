# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit flag-o-matic games

DESCRIPTION="Arkanoid/Breakout clone with pretty graphics."
HOMEPAGE="https://sourceforge.net/projects/sdl-ball"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="leveleditor sound wiiuse"

DEPEND="media-libs/libsdl[opengl]
	media-libs/sdl-ttf
	media-libs/sdl-image
	sound? ( media-libs/sdl-mixer[vorbis] )
	wiiuse? ( games-util/wiiuse )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_prepare() {
	if use !sound; then
		sed -i -e 's:-lSDL_mixer::' Makefile
		rm -r themes/default/snd || die "removing soundfiles failed"
		rm -r themes/dio-sound-theme || die "removing soundfiles failed"
		append-flags "-DNOSOUND"
	fi
}

src_compile() {
	export LIBS

	if use wiiuse; then
		append-flags "-DWITH_WIIUSE"
		LIBS+=" -lwiiuse"
	fi

	emake DATADIR="${dir}/themes/" || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${dir}"
	doins -r themes/ || die "doins failed"

	if use leveleditor; then
		doins -r leveleditor || die "doins failed"
	fi

	dodoc changelog.txt README || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	if use leveleditor; then
		einfo
		einfo "a html/javascript leveleditor has been installed to ${dir}/leveleditor"
		einfo "just point your browser to this location to use the leveleditor."
		einfo "there is additionally a gimp plugin."
		einfo "for futher instructions please see ${dir}/leveleditor/gimp-leveleditor/readme"
		einfo
	fi
}
