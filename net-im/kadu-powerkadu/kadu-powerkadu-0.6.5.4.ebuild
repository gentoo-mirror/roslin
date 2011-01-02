# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-anonymous_check-0.6.5.3
	    >=net-im/kadu-antistring-${PV}
	    >=net-im/kadu-auto_hide-${PV}
	    >=net-im/kadu-autostatus-${PV}
	    >=net-im/kadu-cenzor-${PV}
	    >=net-im/kadu-parser_extender-${PV}
	    >=net-im/kadu-word_fix-${PV}
	    >=net-im/kadu-split_messages-${PV}
	    >=net-im/kadu-gg_avatars-${PV}"

inherit kadu-mod

DESCRIPTION="A set of modules enhancing Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="amd64 x86"

IUSE=""
