SRC_URI="http://kadu.net/~dorr/moduly/${P}.tar.bz2"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module for notifying using the PC Speaker"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
