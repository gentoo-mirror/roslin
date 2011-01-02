# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.6_beta12"
KADU_DIR="unstable"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sound-${PV}
	    || ( media-sound/phonon x11-libs/qt-phonon )"

inherit kadu-mod

DESCRIPTION="Phonon sound output module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""
