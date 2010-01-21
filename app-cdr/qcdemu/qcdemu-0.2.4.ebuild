# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit qt4

DESCRIPTION="A simple frontend for CDemu"
HOMEPAGE="http://my.opera.com/mziab/blog/"
SRC_URI="http://www.jrkrpg.pl/mziab/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="|| ( =x11-libs/qt-4.3*[dbus]
	( x11-libs/qt-gui:4
	x11-libs/qt-dbus:4 ) )"
RDEPEND="${DEPEND}
	>=app-cdr/cdemud-1.2.0"

src_compile() {
	if use nls ;
	then
	lrelease ${PN}.pro || die "lrelease failed"
	fi

	eqmake4 || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc ChangeLog README || die "dodoc failed"
}