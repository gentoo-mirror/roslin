# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MIN_VER="0.9.2"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-history-${PV} >=x11-libs/qt-sql-4.5.0[sqlite]"

inherit kadu-mod

DESCRIPTION="SQL history module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""
