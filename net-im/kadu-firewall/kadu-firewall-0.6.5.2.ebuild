# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-notify-${PV}
	    >=net-im/kadu-history-${PV}"

inherit kadu-mod

DESCRIPTION="Protection against unwanted chats for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
