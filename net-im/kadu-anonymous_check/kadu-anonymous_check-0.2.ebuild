# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://kadu.net/~patryk/anonymous_check/anonymous_check-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module that prints anonymous contact personal information"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
