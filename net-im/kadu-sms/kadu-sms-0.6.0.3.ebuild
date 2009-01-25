# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

MOD_DEPEND=">=net-im/kadu-history-${MIN_REQ}"

inherit kadu-module

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"
DESCRIPTION="Kadu module that provides common API for sms gateway modules"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
