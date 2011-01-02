# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit qt4-r2

DESCRIPTION="QStarDict is a StarDict clone written with using Qt"
HOMEPAGE="http://qstardict.ylsoftware.com/"
SRC_URI="http://qstardict.ylsoftware.com/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64"
IUSE="dbus nls"
RDEPEND=">=dev-libs/glib-2.0
	|| ( =x11-libs/qt-4.3*[dbus?]
	( x11-libs/qt-gui:4
	    dbus? ( x11-libs/qt-dbus:4 ) ) )"
DEPEND="${RDEPEND}"

PATCHES=("${FILESDIR}/${P}-gcc44.patch")

src_configure() {
	local QMAKE_FLAGS
	use dbus || QMAKE_FLAGS+="NO_DBUS=1 "
	use nls || QMAKE_FLAGS+="NO_TRANSLATIONS=1"
	eqmake4 $QMAKE_FLAGS
}
