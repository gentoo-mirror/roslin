# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MIN_VER="0.6.5.4_rc2"

inherit kadu-base

MOD_DEPEND="app-crypt/qca-ossl:2"

inherit kadu-mod

DESCRIPTION="QCA encryption module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""