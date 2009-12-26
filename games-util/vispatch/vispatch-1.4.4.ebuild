# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="WaterVIS utility for glquake"
HOMEPAGE="http://vispatch.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-libs/glibc"

S=${WORKDIR}/${P}/source

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s|OPTIMIZATIONS:= -O2|OPTIMIZATIONS:= ${CFLAGS}|" \
		makefile || die "sed failed"
}

src_install() {
	dobin ${PN} || die "installing the binary failed"

	dodoc ${PN}.txt || die "installing docs failed"
}
