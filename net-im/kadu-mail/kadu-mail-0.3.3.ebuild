SRC_URI="http://www.kadu.net/~weagle/mail/mail-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module notifying user about incoming e-mail messages"
HOMEPAGE="http://kadu.net/~weagle"
KEYWORDS="amd64 x86"
