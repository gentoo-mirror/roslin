# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc3"

inherit kadu-base

MOD_URI="http://kadu.net/~patryk/${NAME}/${NAME}-${NAME}-${PV/_p/-}.tar.bz2"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="Mathematical TeX formula support in Kadu chats"
HOMEPAGE="http://kadu.net/~patryk"
KEYWORDS="~amd64 ~x86"

IUSE=""
