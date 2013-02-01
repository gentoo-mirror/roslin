# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit qt4-r2

DESCRIPTION="A simple frontend for CDemu"
HOMEPAGE="http://my.opera.com/mziab/blog/"
SRC_URI="http://mziab.grajpopolsku.pl/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-dbus:4"
RDEPEND="${DEPEND}
	>=app-cdr/cdemu-daemon-1.2.0"

DOCS="ChangeLog README"

src_prepare() {
	if use nls ; then
	    lrelease ${PN}.pro || die "lrelease failed"
	fi
}
