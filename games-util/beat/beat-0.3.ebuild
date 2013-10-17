# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs

MY_PV="${PV/./}"

DESCRIPTION="A utility for applying and creating BPS patches"
HOMEPAGE="http://byuu.org"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-4.7"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake compiler="$(tc-getCXX)" || die
}

src_install() {
	default
	make_desktop_entry ${PN}
	dohtml ${PN}.html
}
