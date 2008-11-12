#
# PACKAGE INFORMATION
#

MIN_VER="0.6.5_rc2"

inherit kadu-base

MOD_TYPE="ext"
MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}"
MOD_URI="http://kadu.net/~dorr/moduly/${P}.tar.bz2"

inherit kadu-mod

DESCRIPTION="OSD-like notification module for Kadu"
HOMEPAGE="http://kadu.net/~dorr"
KEYWORDS="~amd64 ~x86"

IUSE=""

