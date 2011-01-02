# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
MIN_VER="0.6.5.4"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-mediaplayer-${PV}
kde-base/kdelibs:3.5"

inherit kadu-mod

DESCRIPTION="Amarok 1.x mediaplayer module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""
