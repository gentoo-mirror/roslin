# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs

MY_PV="${PV/0./}"
MY_PV="v${MY_PV/_p/r0}-source"

DESCRIPTION="A higan helper library needed for extra rom load options"
HOMEPAGE="http://byuu.org/higan/"
SRC_URI="http://higan.googlecode.com/files/purify_${MY_PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=">=sys-devel/gcc-4.6"

S="${WORKDIR}/purify_${MY_PV}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-01-makefile.patch" \
		"${FILESDIR}/${PN}-01-gcc46-build.patch"
}

src_compile() {
	emake \
		platform="x" \
		compiler="$(tc-getCXX)" \
	    || die "emake $1 failed"
}
