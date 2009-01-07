SRC_URI="http://kadu.net/~dorr/moduly/water_notify-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND="~net-im/kadu-notify-${MIN_REQ}
	    x11-wm/compiz"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module notifying the user using the water effect from Compiz"
HOMEPAGE="http://kadu.jarzebski.pl/"
KEYWORDS="amd64 x86"
