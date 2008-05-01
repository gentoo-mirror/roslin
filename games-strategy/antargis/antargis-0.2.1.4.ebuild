# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PV="0.2c"
DESCRIPTION="Open-source medieval Realtime-strategy game."
HOMEPAGE="http://antargis.berlios.de/"
SRC_URI="http://download.berlios.de/antargis/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8
	dev-ruby/rake
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf
	media-libs/sdl-mixer"

#src_unpack() {
#	unpack ${A}
#	cd "${S}"
#	epatch "${FILESDIR}/${PN}-wrapper.patch" || die "epatch failed"
#}

src_compile() {
	egamesconf || die "egamesconf failed"
	rake || die "rake failed"
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data docs gui music ruby config.rb editor.rb libantargis.so run.rb || die "doins failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README || die "dodoc failed"
	mv gui/data/sword.png "${PN}.png"
	doicon "${PN}.png" || die "doicon failed"
	make_desktop_entry "${PN}" "Battles of Antargis" "${PN}"
	prepgamesdirs
}
