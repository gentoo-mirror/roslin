SRC_URI="http://kadu.net/download/modules_extra/audacious_mediaplayer/audacious_mediaplayer-${PV}.tar.bz2"

inherit kadu

MOD_CXXFLAGS="`pkg-config audacious --cflags` -I /usr/include/dbus-1.0"
MOD_DEPEND="media-sound/audacious net-im/kadu-mediaplayer"
MOD_LDFLAGS="`pkg-config audacious --libs`"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module for Audacious"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
