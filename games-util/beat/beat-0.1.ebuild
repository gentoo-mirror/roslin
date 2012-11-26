# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PV="${PV/./}"

DESCRIPTION="A utility for applying and creating BPS patches"
HOMEPAGE="http://byuu.org"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.tar.xz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-4.5"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake compiler=gcc || die
}

src_install() {
	dobin ${PN}
	make_desktop_entry ${PN}
}
