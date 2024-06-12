# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-r3 multilib toolchain-funcs

DESCRIPTION="A bsnes helper library needed for extra rom load options"
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
	!<games-emulation/bsnes-0.073[snesreader]"

PATCHED=(
	"${FILESDIR}/${P}-makefile.patch"
)

src_compile() {
	cd ${PN}
	emake platform=x compiler="$(tc-getCC)" qtpath="/usr/lib64/qt5" \
	    || die "emake $1 failed"
}

src_install() {
	cd ${PN}
	newlib.so libsnesreader.so libsnesreader.so.1
	dosym libsnesreader.so.1 /usr/$(get_libdir)/libsnesreader.so
}
