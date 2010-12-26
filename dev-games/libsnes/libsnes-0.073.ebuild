# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils flag-o-matic

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"

DESCRIPTION="Self-contained Super Nintendo emulation core"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/bsnes_v${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sgb"

RDEPEND="sgb? ( dev-games/supergameboy )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gcc-4.4"

S="${WORKDIR}/bsnes"

pkg_setup() {
	use amd64 && append-cxxflags -fPIC
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.073-makefile.patch
}

src_compile() {
	emake platform=x compiler=gcc library || die "emake failed"
}

src_install() {
	dolib.so out/libsnes.so || die
	dolib.a out/libsnes.a || die
}
