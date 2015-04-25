# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"

DESCRIPTION="A bsnes helper library needed for Super Gameboy emulation"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/bsnes_v${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="!<games-emulation/bsnes-0.073[sgb]"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake \
	    platform=x \
	    compiler=gcc \
	    || die "emake $1 failed"
}

src_install() {
	emake \
	    prefix="/usr" \
	    DESTDIR="${D}" install \
	    || die "install $1 failed"
}
