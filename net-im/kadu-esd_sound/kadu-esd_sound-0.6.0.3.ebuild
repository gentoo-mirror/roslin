inherit kadu

MOD_DEPEND="media-sound/esound ~net-im/kadu-sound-${MIN_REQ}"

inherit kadu-module

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"
DESCRIPTION="Kadu module that play sounds using esound"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
