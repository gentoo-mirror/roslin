SRC_URI="http://www.kadu.net/~dorr/moduly/${P}.tar.bz2"

inherit kadu

MOD_DEPEND="
    net-im/kadu-anonymous_check
    net-im/kadu-antistring
    net-im/kadu-auto_hide
    net-im/kadu-cenzor
    net-im/kadu-last_seen
    net-im/kadu-parser_extender
    net-im/kadu-split_messages
    net-im/kadu-word_fix
"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module that appends many interesting features"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
