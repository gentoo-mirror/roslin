# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ} x11-libs/xosd x11-apps/xfontsel"

inherit kadu-module kadu-module-func

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"
DESCRIPTION="Kadu module that supports notification by xosd"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

src_unpack()
{
	kadu-module_src_unpack

	sed -e "/define USE_GTKFONTDIALOG/d" -i xosd_notify/xlfd_chooser.cpp
	kadu-module_spec_remove 3RDPARTY
}
