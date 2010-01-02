# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sound-${PV}
	    || ( media-sound/phonon x11-libs/qt-phonon )"

inherit kadu-mod

DESCRIPTION="Phonon sound output module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
