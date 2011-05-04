# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PV="${PV/./}"

DESCRIPTION="A tool to clean up SNES ROM sets for compatibility with bsnes"
HOMEPAGE="http://byuu.org"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.7z"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt4"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	qt4? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	app-arch/p7zip
	dev-util/pkgconfig
	>=sys-devel/gcc-4.5"

S="${WORKDIR}/${PN}"

REQUIRED_USE="|| ( gtk qt4 )"

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch"
}

src_compile() {
	if use gtk; then
		sh ./cc-gtk.sh || die
	fi

	if use qt4; then
		sh ./cc-qt.sh || die
	fi
}

src_install() {
	use gtk && dobin ${PN}-gtk
	use qt4 && dobin ${PN}-qt
}
