SRC_URI="http://kadu.net/download/modules_extra/falf_mediaplayer/falf_mediaplayer-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND="media-sound/falf ~net-im/kadu-mediaplayer-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module for FALF Player"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
