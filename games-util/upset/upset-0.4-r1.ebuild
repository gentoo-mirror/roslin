# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PV="${PV/./}"

DESCRIPTION="A utility for applying UPS patches"
HOMEPAGE="http://byuu.org"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt4"

REQUIRED_USE="^^ ( gtk qt4 )"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	qt4? ( >=dev-qt/qtgui-4.5:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-4.5"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch"
}

src_compile() {
	if use gtk; then
		./cc-gtk.sh || die
	elif use qt4; then
		./cc-qt.sh || die
	fi
}

src_install() {
	dobin ${PN} || die
}
