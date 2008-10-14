#
# PACKAGE INFORMATION
#
inherit kadu-base

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.net"
KEYWORDS=""

IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.4.1
	>=x11-libs/qt-qt3support-4.4.1
	>=x11-libs/qt-webkit-4.4.1
	>=net-libs/libgadu-1.8.0
	${MOD_DEPEND}"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0"

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"

src_unpack()
{
	# Unpack the sources
	unpack ${A}
	cd ${S}

	# Disable everything besides the core
	kadu-disable_all

	# Enable default icons
	echo "icons_default=y" >> ${S}/.config

	# Enable default emoticons
	echo "emoticons_penguins=y" >> ${S}/.config
}

