# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.im"
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

PATCHES=("${FILESDIR}/${PN}-0.12.0_beta2-cmake.patch")

src_configure() {
	# Disable plugins
	local mycmakeargs="-DBUILD_PLUGINS:BOOL=OFF"

	if use ayatana ; then
		mycmakeargs="${mycmakeargs} -DWITH_LIBINDICATE_QT:BOOL=ON"
	else
		mycmakeargs="${mycmakeargs} -DWITH_LIBINDICATE_QT:BOOL=OFF"
	fi

	if use ntrack ; then
		mycmakeargs="${mycmakeargs} -DNETWORK_IMPLEMENTATION:STRING='ntrack'"
	else
		mycmakeargs="${mycmakeargs} -DNETWORK_IMPLEMENTATION:STRING='Qt'"
	fi

	kadu_src_configure
}

pkg_postinst() {
	ewarn "If you rebuilt the core by hand, recompiling the modules is advised."
	ewarn "You may do so by using emerge -1av \$(qlist -I -C net-im/kadu-)"
	ewarn "This requires app-portage/portage-utils to be installed."
}
