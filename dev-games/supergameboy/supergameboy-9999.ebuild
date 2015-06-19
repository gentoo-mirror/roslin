# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 multilib toolchain-funcs eutils

DESCRIPTION="A bsnes helper library needed for Super Gameboy emulation"
HOMEPAGE="https://github.com/devinacker/bsnes-plus"
SRC_URI=""
EGIT_REPO_URI="https://github.com/devinacker/bsnes-plus.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="!<games-emulation/bsnes-0.073[sgb]"

S="${WORKDIR}/${P}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake platform=x compiler="$(tc-getCC)" \
	    || die "emake $1 failed"
}

src_install() {
	newlib.so libsupergameboy.so libsupergameboy.so.1
	dosym libsupergameboy.so.1 /usr/$(get_libdir)/libsupergameboy.so
}
