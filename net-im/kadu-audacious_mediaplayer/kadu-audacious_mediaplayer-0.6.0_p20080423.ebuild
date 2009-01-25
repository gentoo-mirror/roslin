# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://kadu.net/download/modules_extra/audacious_mediaplayer/audacious_mediaplayer-${PV/0.6.0_p/}.tar.bz2"

inherit kadu

MOD_DEPEND="media-sound/audacious net-im/kadu-mediaplayer"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module for Audacious"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

src_compile()
{
	MOD_CXXFLAGS="`pkg-config audacious --cflags` -I /usr/include/dbus-1.0"
	MOD_LDFLAGS="`pkg-config audacious --libs`"

	kadu-module_src_compile
}
