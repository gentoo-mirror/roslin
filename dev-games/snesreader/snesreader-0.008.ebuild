# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="A bsnes helper library needed for extra rom load options"
HOMEPAGE="http://byuu.org/bsnes/"
MY_PV="${PV/0./}"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.4"
DEPEND="${RDEPEND}"

RESTRICT="strip"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -e "s/-O3/${CXXFLAGS}/" \
	    -i Makefile \
	    || die "sed failed"
}

src_compile() {
	emake platform=x compiler=gcc || die "emake failed"
}

src_install() {
	dolib libsnesreader.* || die "install failed"
}
