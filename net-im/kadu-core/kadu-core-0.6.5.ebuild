#
# PACKAGE INFORMATION
#
inherit kadu-base

DESCRIPTION="The core of Kadu IM"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.4.0
	>=x11-libs/qt-qt3support-4.4.0
	>=x11-libs/qt-webkit-4.4.0
	>=net-libs/libgadu-1.8.0
	!<net-im/kadu-core-0.6.5"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0"

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"

pkg_setup()
{
	# Check for pthread support in libgadu
	if ! built_with_use net-libs/libgadu threads; then
	    die "net-libs/libgadu needs to be built with USE=threads"
	fi
}

src_unpack()
{
	# Unpack the sources
	unpack ${A}
	cd ${S}
	
	# Fix sounds
	epatch ${FILESDIR}/${PN}-fix-sound-install-path.patch

	# Disable everything besides the core
	kadu-disable_all

	# Enable default icons
	echo "icons_default=y" >> ${S}/.config

	# Enable default emoticons
	echo "emoticons_penguins=y" >> ${S}/.config
}

