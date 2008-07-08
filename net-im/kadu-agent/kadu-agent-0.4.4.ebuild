SRC_URI="http://misiek.jah.pl/assets/2008/2/8/agent-0.4.4.tar.gz"

inherit kadu

MOD_TYPE="ext"
MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"

inherit kadu-module

DESCRIPTION="Kadu module allowing to detect who has your UIN in userlist"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
