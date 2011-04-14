# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.0"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-idle-${PV}"

inherit kadu-mod

DESCRIPTION="Kadu module for automatic window hiding"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""