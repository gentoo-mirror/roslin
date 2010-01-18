# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc3"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-anonymous_check-0.6.5.1
	    >=net-im/kadu-antistring-0.6.5.1
	    >=net-im/kadu-auto_hide-0.6.5.1
	    >=net-im/kadu-autostatus-0.6.5.1
	    >=net-im/kadu-cenzor-0.6.5.1
	    >=net-im/kadu-parser_extender-0.6.5.1
	    >=net-im/kadu-word_fix-0.6.5.1
	    >=net-im/kadu-split_messages-0.3
	    >=net-im/kadu-gg_avatars-0.6.5.2"

inherit kadu-mod

DESCRIPTION="A set of modules enhancing Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="~amd64 ~x86"

IUSE=""
