SRC_URI="http://www.kadu.net/~dorr/moduly/${P}.tar.bz2"

inherit kadu

MOD_DEPEND="<net-im/kadu-anonymous_check-0.6.5.1
	<net-im/kadu-antistring-0.6.5
	<net-im/kadu-auto_hide-0.6.5
	<net-im/kadu-cenzor-0.6.5
	<net-im/kadu-last_seen-0.6.5
	<net-im/kadu-parser_extender-0.6.5
	<net-im/kadu-split_messages-0.3
	<net-im/kadu-word_fix-0.6.5"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module that appends many interesting features"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
