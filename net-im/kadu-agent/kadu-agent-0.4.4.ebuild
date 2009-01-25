# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://kadu.net/~dorr/moduly/${P}.tar.gz"

inherit kadu

MOD_TYPE="ext"
MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"

inherit kadu-module

DESCRIPTION="Kadu module allowing to detect who has your UIN in userlist"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
