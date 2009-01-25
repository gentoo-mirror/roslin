# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu-base

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.4.0
	>=x11-libs/qt-qt3support-4.4.0
	>=x11-libs/qt-webkit-4.4.0
	>=x11-libs/qt-dbus-4.4.0
	>=net-libs/libgadu-1.8.0[threads]
	!<net-im/kadu-core-0.6.5"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0"

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"

src_prepare()
{
	# Disable everything besides the core
	kadu-disable_all

	# Enable default icons
	echo "icons_default=y" >> ${S}/.config

	# Enable default emoticons
	echo "emoticons_penguins=y" >> ${S}/.config
}

