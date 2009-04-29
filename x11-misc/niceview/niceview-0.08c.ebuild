# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit qt4

MY_P="${P}-source"

DESCRIPTION="A simple slideshow program for displaying naked women from the program's homepage"
HOMEPAGE="http://sourceforge.net/projects/niceview/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( =x11-libs/qt-4.3*:4
		x11-libs/qt-gui )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i ${PN}.pro -e "s:wiitcpload:niceview:g" \
	    || die "sed failed"
	eqmake4 || die "eqmake4 failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install \
	    || die "emake failed"
}
