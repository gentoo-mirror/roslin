# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"
MY_P="bsnes_v${MY_PV}-source"

DESCRIPTION="Self-contained Super Nintendo emulation core"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="profile_accuracy +profile_compatibility profile_performance"

REQUIRED_USE="^^ ( profile_accuracy profile_compatibility profile_performance )"

RDEPEND=""

DEPEND=">=sys-devel/gcc-4.6
	!dev-games/libsnes-c++98
	!dev-games/snes9x-libsnes"

S="${WORKDIR}/${MY_P}/bsnes"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.083-makefile.patch \
		"${FILESDIR}"/${P}-linker.patch
}

src_compile() {
	local myprofile

	if use profile_accuracy; then
		myprofile="accuracy"
	elif use profile_compatibility; then
		myprofile="compatibility"
	else
		myprofile="performance"
	fi

	emake \
		compiler=gcc \
		profile=${myprofile} \
		ui=ui-libsnes || die "emake failed"
}

src_install() {
	dolib.so out/libsnes.so || die
	dolib.a out/libsnes.a || die
	insinto /usr/include
	doins ui-libsnes/libsnes.hpp || die
}
