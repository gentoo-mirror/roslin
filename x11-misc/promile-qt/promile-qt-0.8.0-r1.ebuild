# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils qt4

DESCRIPTION="A QT4 program for calculating blood alcohol level"
HOMEPAGE="http://piro.wikidot.com/promile-qt"
SRC_URI="http://piro.wikidot.com/local--files/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# not sure about the actual version needed
DEPEND="|| ( ( $(qt4_min_version 4.3) )
	     x11-libs/qt-gui:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
		qmake -project -o ${PN}.pro || die "qmake failed"
		eqmake4 || die "qmake4 failed"
		emake || die "emake failed"
}

src_install() {
		dobin ${PN}
		dodoc README TODO changelog
		make_desktop_entry ${PN}
}

