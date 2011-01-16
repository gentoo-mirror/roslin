# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_PV="${PV/./}"

DESCRIPTION="A tool to clean up SNES ROM sets for compatibility with bsnes"
HOMEPAGE="http://byuu.org"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gcc-4.5"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-build.patch"
}

src_compile() {
	sh ./cc-gtk.sh || die
}

src_install() {
	dobin ${PN} || die
}
