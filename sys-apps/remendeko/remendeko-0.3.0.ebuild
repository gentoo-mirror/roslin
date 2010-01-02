# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_PN="RemenDeKO"
DESCRIPTION="File corruption detection and repair program"
HOMEPAGE="http://rdko.sourceforge.net/"
SRC_URI="mirror://sourceforge/rdko/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.4.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	sed -i \
		-e '/^CFLAGS =/s:-fmessage-length=0 -fexpensive-optimizations -O3:$(E_CFLAGS):' \
		-e '/^CFLAGSGUI/s:-fmessage-length=0 -fexpensive-optimizations -O3:$(CFLAGS):' \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	use gtk && emake E_CFLAGS="${CFLAGS}" || emake E_CFLAGS="${CFLAGS}" rdko || die "emake failed"
}

src_install() {
	dodoc CHANGELOG || die "dodoc failed"
	dobin rdko || die "dobin failed"
	use gtk && dobin gredeko || die "dobin failed"
}
