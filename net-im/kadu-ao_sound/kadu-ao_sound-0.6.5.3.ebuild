# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sound-${PV}
	    media-libs/libao"

inherit kadu-mod

DESCRIPTION="LibAO sound output plugin"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
