# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.6_beta15"
KADU_DIR="unstable"

inherit kadu-base

MOD_DEPEND="net-im/kadu-gadu_protocol
    net-im/kadu-history_migration"

inherit kadu-mod

DESCRIPTION="Imports profiles from older Kadu versions"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""
