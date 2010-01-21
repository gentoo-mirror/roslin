# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc3"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sound-${PV}"

inherit kadu-mod

DESCRIPTION="Qt4 sound output module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""