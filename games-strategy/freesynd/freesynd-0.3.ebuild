# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Remake of the classic Syndicate game by Bullfrog"
HOMEPAGE="http://freesynd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"/src

	# Customize directory
	sed -i \
		-e "s:\"./:\"${dir}/:" \
		file.cpp || die "sed file.cpp"

	sed -i \
		-e "s:loadMusicFile(\":loadMusicFile(\"${dir}/:" \
		musicmanager.cpp || die "sed musicmanager.cpp"

#	epatch "${FILESDIR}/${PN}-gcc43.patch"
}

src_compile() {
	cd "${S}"/src
	emake
}

src_install() {
	dogamesbin "${S}/src/${PN}" || die
#	newgamesbin dump ${PN}-dump || die
#	newgamesbin dumpmaps ${PN}-dumpmaps || die

	insinto "${dir}"
#	doins ../*.mp3 || die
	doins -r "${S}/bin/data" || die

	dodoc R*txt

	make_desktop_entry ${PN} "Free Syndicate"

	prepgamesdirs
}
