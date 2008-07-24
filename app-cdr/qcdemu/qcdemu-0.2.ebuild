# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4

EAPI="1"

DESCRIPTION="A simple frontend for CDemu"
HOMEPAGE="http://my.opera.com/mziab/blog/"
SRC_URI="http://195.68.226.253/mziab/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( ( $(qt4_min_version 4.3) )
	x11-libs/qt-gui:4 )"
RDEPEND="${DEPEND}
	>=app-cdr/cdemu-1.1.0"

S="${WORKDIR}/${PN}"

pkg_setup() {
	if has_version ">=x11-libs/qt-4.3:4"; then
		QT4_BUILT_WITH_USE_CHECK="dbus"
	else
		if ! built_with_use "x11-libs/qt-gui:4" dbus; then
			eerror "You have to built x11-libs/qt-gui:4 with dbus."
			die "dbus in qt-gui disabled"
		fi
	fi
	qt4_pkg_setup
}

src_compile() {
	eqmake4 || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
}
