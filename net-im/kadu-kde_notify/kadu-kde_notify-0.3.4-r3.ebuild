# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4"

inherit kadu-base

MOD_TYPE="ext"
MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}
	    >=kde-base/knotify-4.2"
MOD_URI="http://kadu.net/~dorr/moduly/${NAME}-${PV}.tar.gz"
MOD_PATCHES="${NAME}-kde44-compat.patch"

inherit kadu-mod

DESCRIPTION="Kadu module for KDE4 notifications"
HOMEPAGE="http://kadu.net/~dorr"
KEYWORDS="amd64 x86"

IUSE=""