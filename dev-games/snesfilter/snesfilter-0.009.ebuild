# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_PV="${PV/0./}"

DESCRIPTION="A bsnes helper library which provides image filters"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i Makefile \
	    -e "s/-O3/${CXXFLAGS}/" \
	    -e "s/-s //" \
	    || die "sed failed"
}

src_compile() {
	emake platform=x compiler=gcc || die "emake failed"
}

src_install() {
	dolib libsnesfilter.so || die "install failed"
}
