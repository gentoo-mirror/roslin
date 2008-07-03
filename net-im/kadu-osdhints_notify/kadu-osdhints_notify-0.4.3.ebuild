SRC_URI="http://www.kadu.net/~dorr/moduly/${P}.tar.bz2"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module notifying user using pretty osd widgets"
HOMEPAGE="http://kadu.net/~dorr"
KEYWORDS="amd64 x86"
