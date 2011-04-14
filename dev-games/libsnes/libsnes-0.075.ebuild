# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"
MY_P="bsnes_v${MY_PV}-source"

DESCRIPTION="Self-contained Super Nintendo emulation core"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="profile_accuracy +profile_compatibility profile_performance sgb"

RDEPEND="sgb? ( dev-games/supergameboy )"

DEPEND=">=sys-devel/gcc-4.5"

S="${WORKDIR}/${MY_P}/bsnes"

pkg_setup() {
	confutils_require_one profile_accuracy profile_compatibility profile_performance
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.075-makefile.patch
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

	emake compiler=gcc profile=${myprofile} ui=ui-libsnes || die "emake failed"
}

src_install() {
	dolib.so out/libsnes.so || die
	dolib.a out/libsnes.a || die
	insinto /usr/include
	doins ui-libsnes/libsnes.hpp || die
}