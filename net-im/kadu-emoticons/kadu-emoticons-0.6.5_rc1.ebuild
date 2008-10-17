#
# PACKAGE INFORMATION
#
inherit kadu-base

DESCRIPTION="Extra emoticons for Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND="net-im/kadu-core"

SRC_URI="http://www.kadu.net/download/additions/kompatybilne_z_GG6.tar.gz
	http://www.kadu.net/download/additions/tango_static.tar.gz"

S="${WORKDIR}"

src_compile()
{
    einfo "Nothing to compile."
}

src_install()
{
	local DIR="/usr/share/kadu/themes/emoticons/"

	dodir ${DIR}
	for i in *;
	do
	    mv -f $i ${D}${DIR};
	done
}
