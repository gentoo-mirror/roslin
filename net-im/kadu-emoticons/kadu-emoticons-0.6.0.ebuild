#
# PACKAGE INFORMATION
#
inherit kadu

DESCRIPTION="Collection of Kadu emoticon themes"
HOMEPAGE="http://www.kadu.net/wiki/index.php/Pobierz:dodatki"
KEYWORDS="amd64 x86"

LICENSE="freedist"

IUSE=""
SLOT="0"
DEPEND="net-im/kadu-core"

SRC_URI="
    http://kadu.net/download/additions/kompatybilne_z_GG6.tar.gz
    http://kadu.net/download/additions/dodatkowe_emoty_GG7.tar.gz
    http://kadu.net/download/additions/kadu-emots-zestaw288.tar.bz2
    http://kadu.net/download/additions/tango_static.tar.gz
    http://kadu.net/download/additions/kadu-emots-tex.tar.gz
"

DEST="/usr/share/kadu/themes/emoticons"

#
# PACKAGE BUILDING AND INSTALLATION
#
src_install()
{
	einfo "Creating ${DEST} directory and moving icons..."
	dodir ${DEST}

	dodir ${DEST}/{288,gg7,tango,tex}
	mv ${WORKDIR}/zestaw_288/* ${D}${DEST}/288
	mv ${WORKDIR}/kompatybilne_z_GG6/* ${D}${DEST}/gg7
	mv ${WORKDIR}/3 ${D}${DEST}/gg7
	mv ${WORKDIR}/tango/* ${D}${DEST}/tango
	mv ${WORKDIR}/kaduemotex/TeX/* ${D}${DEST}/tex

	# Fix file permissions
	cd  ${D}${DEST}
	kadu_install_fix_perms
}
