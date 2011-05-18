# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.1"

inherit kadu-base

MY_PV="${PV/_p/-}"
MY_PV="${MY_PV/0.9.0/0.9.x}"

MOD_URI="http://www.ultr.pl/kadu/${NAME}-${MY_PV}.tar.gz"
MOD_TYPE="ext"

MOD_DEPEND=">=net-im/kadu-gadu_protocol-${MIN_VER}
>=net-im/kadu-encryption_ng-${MIN_VER}"

inherit kadu-mod

DESCRIPTION="Automatically splits too long messages"
HOMEPAGE="http://www.ultr.pl/kadu/"
KEYWORDS="~amd64 ~x86"

IUSE=""
