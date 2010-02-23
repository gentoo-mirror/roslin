# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4-r2

DESCRIPTION="A modern music player and library organiser"
HOMEPAGE="http://code.google.com/p/clementine-player/"
SRC_URI="http://clementine-player.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/qt-sql:4
	media-libs/liblastfm
	media-libs/xine-lib
	media-libs/taglib
	x11-libs/libnotify
	dev-libs/glib"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}-install.patch"
	"${FILESDIR}/${P}-desktop.patch")

src_install() {
	qt4-r2_src_install

# icons and .desktop
	newicon dist/${PN}_64.png ${PN}.png || die
	insinto /usr/share/applications
	doins dist/${PN}.desktop || die
}
