# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4

DESCRIPTION="QStarDict is a StarDict clone written with using Qt"
HOMEPAGE="http://qstardict.ylsoftware.com/"
SRC_URI="http://qstardict.ylsoftware.com/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64"
IUSE="dbus nls"
RDEPEND=">=dev-libs/glib-2.0
		||	( >=x11-libs/qt-4.2.0:4[dbus?]
			( x11-libs/qt-gui:4
			dbus? ( x11-libs/qt-dbus:4 ) ) )"
DEPEND="${RDEPEND}"

src_compile() {
	QMAKE_FLAGS=""
	if ! use dbus; then
		QMAKE_FLAGS+="NO_DBUS=1 "
	fi
	if ! use nls; then
		QMAKE_FLAGS+="NO_TRANSLATIONS=1 "
	fi
	eqmake4 $QMAKE_FLAGS || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install filed"
}

