# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4-r2 games

MY_P="Osmose-${PV//./-}-QT"

DESCRIPTION="Osmose is a GPL'd Sega Master System/Gamegear emulator"
HOMEPAGE="http://bcz.asterope.fr/"
SRC_URI="http://bcz.asterope.fr/${PN}/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	sys-libs/zlib[minizip]
	>=dev-qt/qtgui-4.6:4
	>=dev-qt/qtopengl-4.6:4"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PN}-unbundle-minizip.patch"
	"${FILESDIR}/${P}-gcc47.patch" )

src_prepare() {
	qt4-r2_src_prepare
	eqmake4
}

src_install() {
	newgamesbin ${MY_P} ${PN} || die "dobin failed"
	make_desktop_entry ${PN}
	dodoc Readme.txt TODO.txt
	prepgamesdirs
}
