# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc1"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-account_management-${PV}
	    >=net-im/kadu-sound-${PV}"

inherit kadu-mod

DESCRIPTION="Configuration wizard for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""

