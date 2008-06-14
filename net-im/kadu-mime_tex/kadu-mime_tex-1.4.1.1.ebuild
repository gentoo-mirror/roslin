SRC_URI="http://kadu.net/~patryk/mime_tex/mime_tex-${PV}.tar.bz2"

MOD_PATCHES="mime_tex-fix-includes.patch"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module that allows to create images with complicated math formulas"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
