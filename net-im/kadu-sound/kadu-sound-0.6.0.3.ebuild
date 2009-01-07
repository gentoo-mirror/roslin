inherit kadu

MOD_DEPEND="media-libs/libsndfile ~net-im/kadu-notify-${MIN_REQ}"

inherit kadu-module

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"
DESCRIPTION="Kadu module that provides common API for sound modules"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
