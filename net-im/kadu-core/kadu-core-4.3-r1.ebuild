# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kadu

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.im"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtwebkit-5.2.0:5
	>=dev-qt/qtdbus-5.2.0:5
	>=dev-qt/qtsvg-5.2.0:5
	>=dev-qt/qtwidgets-5.2.0:5
	>=dev-qt/qtx11extras-5.2.0:5
	>=dev-qt/qtdeclarative-5.2.0:5[widgets]
	>=dev-qt/linguist-tools-5.2.0:5
	>=dev-qt/qtxml-5.2.0:5
	x11-libs/libXfixes
	>=app-arch/libarchive-2.6[lzma]
	>=dev-libs/injeqt-1.1.0"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-4.0_alpha1-missing-includes.patch" 
	"${FILESDIR}/${P}-gcc7.patch" )

src_configure() {
	# Disable plugins
	local mycmakeargs="-DBUILD_PLUGINS:BOOL=OFF -DENABLE_TESTS:BOOL=OFF"

	kadu_src_configure
}

pkg_postinst() {
	ewarn "If you rebuilt the core by hand, recompiling the modules is advised."
	ewarn "You may do so by using emerge -1av \$(qlist -I -C net-im/kadu-)"
	ewarn "This requires app-portage/portage-utils to be installed."
}