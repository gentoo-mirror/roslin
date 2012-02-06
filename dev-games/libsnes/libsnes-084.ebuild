# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib

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

S="${WORKDIR}/bsnes"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-083-makefile.patch \
		"${FILESDIR}"/${P}-linker.patch \
		"${FILESDIR}"/${P}-build.patch

	sed -i "ui-libsnes/Makefile" \
		-e "s:lib/:$(get_libdir)/:g" \
		|| die
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
	emake DESTDIR="${D}" ui=ui-libsnes prefix=/usr install || die
	insinto /usr/include
	doins ui-libsnes/libsnes.hpp || die
}
