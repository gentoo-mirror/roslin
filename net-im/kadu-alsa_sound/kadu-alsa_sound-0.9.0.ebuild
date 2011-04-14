# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.0"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sound-${PV}
	    media-libs/alsa-lib"

inherit kadu-mod

DESCRIPTION="ALSA sound output module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""