# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-r3 multilib toolchain-funcs

DESCRIPTION="A bsnes helper library which provides image filters"
HOMEPAGE="https://github.com/devinacker/bsnes-plus"
SRC_URI=""
EGIT_REPO_URI="https://github.com/devinacker/bsnes-plus.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtgui-5.4:5
	>=dev-qt/qtwidgets-5.4:5"
DEPEND="${RDEPEND}
	sys-devel/gcc[openmp]
	!<games-emulation/bsnes-0.073[snesfilter]"

S="${WORKDIR}/${P}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-qt5.patch"
}

src_compile() {
	emake platform=x compiler="$(tc-getCC)" \
	    || die "emake $1 failed"
}

src_install() {
	newlib.so libsnesfilter.so libsnesfilter.so.1
	dosym libsnesfilter.so.1 /usr/$(get_libdir)/libsnesfilter.so
}
