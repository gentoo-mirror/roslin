# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit qt4-r2

DESCRIPTION="A lightweight file manager"
HOMEPAGE="http://www.qtfm.org"
SRC_URI="http://www.qtfm.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN} || die
	domenu ${PN}.desktop || die
	doicon images/${PN}.png || die
}

