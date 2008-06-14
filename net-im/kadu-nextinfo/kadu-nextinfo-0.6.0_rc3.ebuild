SRC_URI="http://www.ultr.pl/kadu/nextinfo-${PV/_/-}.tar.gz"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="A module providing extended contact information support"
HOMEPAGE="http://www.ultr.pl/kadu"
KEYWORDS="amd64 x86"
