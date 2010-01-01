# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc2"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}
	    >=net-im/kadu-qt4_docking-${MIN_VER}"

inherit kadu-mod

DESCRIPTION="Kadu notification using Qt4 docking module"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"

IUSE=""
