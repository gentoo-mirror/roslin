# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"

DESCRIPTION="A bsnes helper library which provides image filters"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/bsnes_v${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtgui-4.5:4"
DEPEND="${RDEPEND}
	sys-devel/gcc[openmp]
	!<games-emulation/bsnes-0.073[snesfilter]"

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
