# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs

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

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"

	dodoc ${PN}.txt || die "dodoc failed"
}
