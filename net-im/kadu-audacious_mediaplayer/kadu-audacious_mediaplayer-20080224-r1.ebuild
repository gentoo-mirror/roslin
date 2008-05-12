SRC_URI="http://kadu.net/download/modules_extra/audacious_mediaplayer/audacious_mediaplayer-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND="media-sound/audacious net-im/kadu-mediaplayer"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module for Audacious"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"

src_compile()
{
	export MOD_CXXFLAGS="`pkg-config audacious --cflags` -I /usr/include/dbus-1.0"
	export MOD_LDFLAGS="`pkg-config audacious --libs`"

	kadu-module_src_compile
}
