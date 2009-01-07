#
# PACKAGE INFORMATION
#

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-anonymous_check-0.6.5.1
	    ~net-im/kadu-antistring-${MIN_VER}
	    ~net-im/kadu-auto_hide-${MIN_VER}
	    ~net-im/kadu-autostatus-${MIN_VER}
	    ~net-im/kadu-cenzor-${MIN_VER}
	    ~net-im/kadu-parser_extender-${MIN_VER}
	    ~net-im/kadu-word_fix-${MIN_VER}
	    >=net-im/kadu-split_messages-0.3"
MOD_URI="http://www.kadu.net/~dorr/moduly/kadu-powerkadu-${PV}.tar.bz2"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="A set of modules enhancing Kadu"
HOMEPAGE="http://kadu.net/~dorr"
KEYWORDS="amd64 x86"

IUSE=""

