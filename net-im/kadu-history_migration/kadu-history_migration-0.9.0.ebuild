# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.0"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sql_history-${PV} >=net-im/kadu-gadu_protocol-${PV}"

inherit kadu-mod

DESCRIPTION="History migration module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""
