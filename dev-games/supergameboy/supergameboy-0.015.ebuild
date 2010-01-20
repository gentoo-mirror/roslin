# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_PV="${PV/0./}"

DESCRIPTION="A bsnes helper library for Super Gameboy emulation"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://byuu.org/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i Makefile \
	    -e "s/-O3/${CXXFLAGS}/" \
	    -e "/link += -s/d" \
	    || die "sed failed"
}

src_compile() {
	emake platform=x compiler=gcc || die "emake failed"
}

src_install() {
	dolib libsupergameboy.so || die "install failed"
}
