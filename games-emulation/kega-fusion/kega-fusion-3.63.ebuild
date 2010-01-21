# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="Sega SG1000/SC3000/Master System/Game Gear/Genesis/Megadrive/SVP/Pico/SegaCD/MegaCD/32X emulator"
HOMEPAGE="http://www.eidolons-inn.net/tiki-index.php?page=Kega"
SRC_URI="http://www.eidolons-inn.net/tiki-download_file.php?fileId=572 -> ${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
IUSE="mp3"

QA_PRESTRIPPED="${GAMES_BINDIR:1}/${PN}"

S="${WORKDIR}/Fusion"

DEPEND="virtual/opengl
	x11-libs/gtk+:2[xinerama]
	media-libs/alsa-lib
	mp3? ( media-sound/mpg123 )"
RDEPEND="${DEPEND}"

src_install() {
	newgamesbin Fusion ${PN} || die "dobin failed"
	dodoc History.txt Readme.txt || die "dodoc failed"

	make_desktop_entry ${PN} "Kega Fusion"

	prepgamesdirs
}

pkg_postinst() {
	elog "If you wish for have ISO+MP3 for SegaCD games,"
	elog "you need to set the 'mp3' flag and manually fix"
	elog "libmpg123path in ~/.Kega Fusion/Fusion.ini."
	elog "Moreover, if you want additional graphics filters,"
	elog "please download them from ${HOMEPAGE} and extract"
	elog "them to ~/.Kega Fusion/Plugins."

	games_pkg_postinst
}
