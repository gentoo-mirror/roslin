# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.0"

inherit kadu-base

MOD_DEPEND="net-dns/libidn >=app-crypt/qca-ossl-2.0 sys-libs/zlib"

inherit kadu-mod

DESCRIPTION="Jabber support module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""
