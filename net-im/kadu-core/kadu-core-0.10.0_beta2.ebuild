# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.net"
KEYWORDS=""

IUSE="+ntrack"

RDEPEND="app-crypt/qca:2
	>=x11-libs/qt-gui-4.7.0
	>=x11-libs/qt-webkit-4.7.0
	>=x11-libs/qt-dbus-4.7.0
	>=x11-libs/qt-svg-4.7.0
	x11-libs/libXfixes
	ntrack? ( >=net-libs/ntrack-0.14[qt4] )"

DEPEND="${RDEPEND}"

src_prepare() {
	# Disable plugins
	sed -e "/plugins/d" -i CMakeLists.txt || die
}

pkg_postinst() {
	ewarn "If you rebuilt the core by hand, recompiling the modules is advised."
	ewarn "You may do so by using emerge -1av \$(qlist -I -C net-im/kadu-)"
	ewarn "This requires app-portage/portage-utils to be installed."
}
