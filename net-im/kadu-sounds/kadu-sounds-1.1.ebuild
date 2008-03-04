#
# PACKAGE INFORMATION
#
inherit kadu

DESCRIPTION="Collection of Kadu sound themes"
HOMEPAGE="http://www.kadu.net/wiki/index.php/Pobierz:dodatki"
KEYWORDS="amd64 x86"

LICENSE="freedist"

IUSE=""
SLOT="0"
DEPEND="net-im/kadu-sound net-im/kadu-core"

SRC_URI="http://www.kadu.net/download/additions/kadu-sounds.tar.gz"

DEST="/usr/share/kadu/themes/sounds"

#
# PACKAGE BUILDING AND INSTALLATION
#
src_install()
{
	einfo "Creating ${DEST} directory and moving sounds..."
	dodir ${DEST}

	mv ${WORKDIR}/sounds/* ${D}${DEST}
	cd ${D}${DEST}

	# Fix directory structure
	kadu_install_fix_dir_struct

	# Fix file permissions
	kadu_install_fix_perms
}
