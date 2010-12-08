# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MIN_VER="0.6.6_beta12"

inherit kadu-base

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.net"
KEYWORDS=""

IUSE=""


RDEPEND=">=x11-libs/qt-gui-4.5.0[qt3support]
	>=x11-libs/qt-qt3support-4.5.0
	>=x11-libs/qt-webkit-4.5.0
	x11-libs/libXfixes
	!<net-im/kadu-core-0.6.5"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0"

SRC_URI="http://www.kadu.net/download/unstable/kadu-${K_PV}.tar.bz2"

src_prepare() {
	# Disable everything besides the core
	kadu-disable_all

	# Enable default icons
	echo "icons_default=y" >> ${S}/.config

	# Enable default emoticons
	echo "emoticons_penguins=y" >> ${S}/.config
}

pkg_postinst() {
	ewarn "If you rebuilt the core by hand, recompiling the modules is advised."
	ewarn "You may do so by using emerge -1av \$(qlist -I -C net-im/kadu-)"
	ewarn "This requires app-portage/portage-utils to be installed."
}
