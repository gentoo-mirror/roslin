# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs

MY_PV="${PV/0./}"
MY_P="${PN}_v${MY_PV/_p/r0}-source"

DESCRIPTION="Converts roms to game folders used by higan"
HOMEPAGE="http://byuu.org/higan/"
SRC_URI="http://higan.googlecode.com/files/${MY_P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt4"

COMMON_DEPEND="gtk? ( x11-libs/gtk+:2 )
	qt4? ( >=x11-libs/qt-gui-4.5:4 )"
RDEPEND="${COMMON_DEPEND}
	dev-games/ananke"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/gcc-4.6"

S="${WORKDIR}/${MY_P}/${PN}"

REQUIRED_USE="^^ ( gtk qt4 )"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch" \
		"${FILESDIR}/${P}-gcc46-build.patch"

	cd phoenix/qt && moc -i -I. -o platform.moc platform.moc.hpp
}

src_compile() {
	local mytoolkit

	if use gtk; then
		mytoolkit="gtk"
	else
		mytoolkit="qt"
	fi

	emake \
		platform="x" \
		compiler="$(tc-getCXX)" \
		phoenix="$mytoolkit" \
	    || die "emake $1 failed"
}
