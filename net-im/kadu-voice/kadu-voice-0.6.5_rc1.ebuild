#
# PACKAGE INFORMATION
#

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-dcc-${PV}
	    >=net-im/kadu-sound-${PV}"
MOD_PATCHES="${PN}-libgsm.patch"

inherit kadu-mod

DESCRIPTION="Voice chat module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

