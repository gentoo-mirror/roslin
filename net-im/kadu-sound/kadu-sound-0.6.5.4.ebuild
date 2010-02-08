# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-notify-${PV}
	>=media-libs/libsndfile-1.0"

inherit kadu-mod

DESCRIPTION="Sound support module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
