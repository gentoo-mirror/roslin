# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-anonymous_check-0.6.5.1
	    >=net-im/kadu-antistring-0.6.5.1
	    >=net-im/kadu-auto_hide-0.6.5.1
	    >=net-im/kadu-autostatus-0.6.5.1
	    >=net-im/kadu-cenzor-0.6.5.1
	    >=net-im/kadu-parser_extender-0.6.5.1
	    >=net-im/kadu-word_fix-0.6.5.1
	    >=net-im/kadu-split_messages-0.3"
MOD_URI="http://www.kadu.net/~dorr/moduly/kadu-powerkadu-${PV}.tar.bz2"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="A set of modules enhancing Kadu"
HOMEPAGE="http://kadu.net/~dorr"
KEYWORDS="amd64 x86"

IUSE=""

