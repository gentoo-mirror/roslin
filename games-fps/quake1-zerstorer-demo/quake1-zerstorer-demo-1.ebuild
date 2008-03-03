# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MOD="zerdem"
M="ftp://ftp.planetmirror.com/pub/idgames2/partial_conversions/zerstoerer"
B="ftp://ftp.fu-berlin.de/pc/games/idgames2/partial_conversions/zerstoerer"
Q="http://www.quaddicted.com/filebase"
G="http://www.gamers.org/pub/idgames2/partial_conversions/zerstoerer"

DESCRIPTION="Demo for Quake 1 conversion"
HOMEPAGE="http://shotgun1.shackspace.com/"
SRC_URI="${M}/${MOD}.zip
	${B}/${MOD}.zip
	${Q}/${MOD}.zip
	${G}/${MOD}.zip"

# See zer.txt
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# Needs the CD data
RDEPEND="games-fps/quake1-data
	games-fps/darkplaces"
DEPEND="app-arch/unzip"

S=${WORKDIR}/zerdem
dir=${GAMES_DATADIR}/quake1/${MOD}

src_install() {
	insinto "${dir}"
	doins *.pak || die "doins failed"

	# Wrapper for darkplaces engine. Will probably work with other engines.
	games_make_wrapper darkplaces-zerstorer-demo "darkplaces -game ${MOD}"
	make_desktop_entry darkplaces-zerstorer-demo "Dark Places (Zerstorer-demo)" darkplaces.png

	dodoc *.txt

	prepgamesdirs
}
