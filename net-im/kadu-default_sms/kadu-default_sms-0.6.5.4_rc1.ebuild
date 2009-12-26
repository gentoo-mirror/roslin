# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc1"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sms-${PV}"

inherit kadu-mod

DESCRIPTION="The default Kadu module for sending text messages"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""
