# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.im"
KEYWORDS=" ~amd64 ~x86"

IUSE="ayatana +ntrack"

RDEPEND="app-crypt/qca:2
	>=dev-qt/qtgui-4.8.0:4
	>=dev-qt/qtwebkit-4.8.0:4
	>=dev-qt/qtdbus-4.8.0:4
	>=dev-qt/qtsvg-4.8.0:4
	x11-libs/libXfixes
	>=app-arch/libarchive-2.6[lzma]
	ayatana? ( dev-libs/libindicate-qt )
	ntrack? ( >=net-libs/ntrack-0.14[qt4] )"

DEPEND="${RDEPEND}"

PATCHES=("${FILESDIR}/${P}-cmake-install-prefix.patch")

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
