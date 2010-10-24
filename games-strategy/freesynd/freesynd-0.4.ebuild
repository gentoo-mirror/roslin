# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils games

DESCRIPTION="Remake of the classic Syndicate game by Bullfrog"
HOMEPAGE="http://freesynd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_prepare() {
	# Customize directory
	sed -i \
		-e "s:\"./:\"${dir}/:" \
		"${S}"/src/file.cpp || die "sed file.cpp"

	sed -i \
		-e "s:loadMusicFile(\":loadMusicFile(\"${dir}/:" \
		"${S}"/src/musicmanager.cpp || die "sed musicmanager.cpp"
}

src_compile() {
	cd "${S}"/src
	emake
}

src_install() {
	dogamesbin "${S}/bin/${PN}" || die

	dodoc R*txt

	make_desktop_entry ${PN} "Free Syndicate"

	prepgamesdirs
}
