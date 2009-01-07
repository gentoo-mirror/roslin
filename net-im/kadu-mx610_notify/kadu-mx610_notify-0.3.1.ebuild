SRC_URI="http://kadu.net/~dorr/moduly/mx610_notify-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND="~net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module notifying user using Logitech's MX 610 Mouse leds"
HOMEPAGE="http://kadu.jarzebski.pl"
KEYWORDS="amd64 x86"
