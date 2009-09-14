# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sms-${MIN_VER}"
MOD_URI="http://kadu.net/~patryk/${NAME}/${NAME}-${NAME}-${PV/_p/-}.tar.bz2"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="Plus.pl text message module for Kadu"
HOMEPAGE="http://kadu.net/~patryk"
KEYWORDS="amd64 x86"

IUSE=""

