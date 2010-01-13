# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="sp-auth"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="SopCast free P2P Internet TV binary"
LICENSE="SopCast-unknown-license"
HOMEPAGE="http://www.sopcast.com/"
SRC_URI="http://sopcast-player.googlecode.com/files/${MY_P}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

# All dependencies might not be listed, since the binary blob's homepage only lists libstdc++
RDEPEND="amd64? ( app-emulation/emul-linux-x86-compat )
	x86? ( >=virtual/libstdc++-3.3 )"

DEPEND="${RDEPEND}"

src_install() {
	exeinto /opt/${PN}
	doexe sp-sc-auth || die "doexe failed"
	dosym /opt/${PN}/sp-sc-auth /usr/bin/sp-sc
	dodoc Readme || die "dodoc failed"
}
