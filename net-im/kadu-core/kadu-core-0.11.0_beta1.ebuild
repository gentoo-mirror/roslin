# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.net"
KEYWORDS=""

IUSE="ayatana +ntrack"

RDEPEND="app-crypt/qca:2
	>=x11-libs/qt-gui-4.7.0
	>=x11-libs/qt-webkit-4.7.0
	>=x11-libs/qt-dbus-4.7.0
	>=x11-libs/qt-svg-4.7.0
	x11-libs/libXfixes
	ayatana? ( dev-libs/libindicate-qt )
	ntrack? ( >=net-libs/ntrack-0.14[qt4] )"

DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-cmake.patch" )

src_configure() {
	# Disable plugins
	local mycmakeargs="-DBUILD_PLUGINS:BOOL=OFF"

	use ayatana && mycmakeargs="${mycmakeargs} -DWITH_LIBINDICATE_QT:BOOL=ON"

	if use ntrack ; then
		mycmakeargs="${mycmakeargs} -DNETWORK_IMPLEMENTATION=ntrack"
	else
		mycmakeargs="${mycmakeargs} -DNETWORK_IMPLEMENTATION=Qt"
	fi

	kadu_src_configure
}

pkg_postinst() {
	ewarn "If you rebuilt the core by hand, recompiling the modules is advised."
	ewarn "You may do so by using emerge -1av \$(qlist -I -C net-im/kadu-)"
	ewarn "This requires app-portage/portage-utils to be installed."
}