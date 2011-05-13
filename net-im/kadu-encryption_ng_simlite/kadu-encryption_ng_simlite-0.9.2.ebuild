# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MIN_VER="0.9.2"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-encryption_ng-${MIN_VER}
    app-crypt/qca-ossl:2
    !net-im/kadu-encryption
    !net-im/kadu-ecnryption_old"

inherit kadu-mod

DESCRIPTION="QCA encryption module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE=""