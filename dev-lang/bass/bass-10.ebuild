# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="A multi-target cross assembler"
HOMEPAGE="http://byuu.org"
SRC_URI="http://byuu.org/files/${PN}_v${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=">=sys-devel/gcc-4.6"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake compiler="$(tc-getCC)" || die
}

src_install() {
	default
	dohtml doc/*.html doc/*.css
}
