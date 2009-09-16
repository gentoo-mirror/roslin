# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-mediaplayer-${PV}"
MOD_PATCHES="qtdbus-link.patch"

inherit kadu-mod

DESCRIPTION="Dragon Player mediaplayer module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

