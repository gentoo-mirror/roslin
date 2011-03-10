# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.5"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-dcc-${PV}
	    >=net-im/kadu-sound-${PV}"
MOD_PATCHES="${PN}-libgsm.patch"

inherit kadu-mod

DESCRIPTION="Voice chat module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
