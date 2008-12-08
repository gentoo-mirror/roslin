SRC_URI="http://kadu.net/download/modules_extra/spellchecker/spellchecker-${PV/0./}.tar.bz2"

MOD_DEPEND="app-text/aspell"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module adding spellchecking with aspell to chat window"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
