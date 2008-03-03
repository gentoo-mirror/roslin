# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="sp-auth"

DESCRIPTION="SopCast free P2P Internet TV binary"
LICENSE="SopCast-unknown-license"
HOMEPAGE="http://www.sopcast.com/"
#SRC_URI="http://download.sopcast.org/download/${MY_SRC}"
SRC_URI="http://download.sopcast.cn/download/${MY_P}.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# All dependencies might not be listed, since the binary blob's homepage only lists libstdc++
RDEPEND=">=virtual/libstdc++-3.3"

DEPEND="${RDEPEND}"

S=${WORKDIR}/sp-auth/


src_unpack() {
	ewarn "SopCast binary blob is distributed without version info in its package."
	ewarn "Thus, in case this ebuild fails, you might want to remove your " $MY_SRC
	ewarn "from /usr/portage/distfiles and check whether they have release a newer"
	ewarn "version on their homepage at"
	ewarn $HOMEPAGE

	unpack ${A}
}

src_install() {
	cd ${S}
	dobin sp-sc-auth
	# we need to make the above available for older stuff expecting to find it with the old name
	ln -s ${D}/usr/bin/sp-sc-auth ${D}/usr/bin/sp-sc
	dobin sp-so-auth
	dodoc Readme
}
