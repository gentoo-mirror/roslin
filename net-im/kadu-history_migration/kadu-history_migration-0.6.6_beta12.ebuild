# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.6_beta12"
KADU_DIR="unstable"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sql_history-${PV} >=net-im/kadu-gadu_protocol-${PV}"

inherit kadu-mod

DESCRIPTION="History migration module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""
