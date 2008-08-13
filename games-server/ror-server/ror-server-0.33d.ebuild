# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.8.1.ebuild,v 1.1 2007/07/04 01:25:10 mr_bones_ Exp $

inherit autotools games

MY_PN="${PN/ror-/RoR}"
MY_PV="${PV}-SP1"
MY_PN1="${PN/-/}"

DESCRIPTION="Server for Rigs of Rods"
HOMEPAGE="http://rigsofrods.blogspot.com/"
SRC_URI="http://repository.rigsofrods.com/files/${MY_PN}-${MY_PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gcc"

S=${WORKDIR}/${MY_PN}-${MY_PV}/sources

src_unpack() {
	unpack ${A}
	cd "${S}"
#	sed -i \
#		-e "s|CFLAGS=-c|CFLAGS = ${CFLAGS}|" \
#		Makefile || die "sed"
	rm -r ../win32
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodoc README
	dohtml -r SocketW/docs
	dobin ${MY_PN1}
}

#pkg_postinst() {
#	einfo ""
#	einfo "Example config file and run file can be found in"
#	einfo "/usr/share/doc/${P}/"
#	einfo ""
#}
