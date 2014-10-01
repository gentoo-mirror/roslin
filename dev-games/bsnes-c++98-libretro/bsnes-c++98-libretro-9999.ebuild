# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib git-2

DESCRIPTION="bsnes emulation core ported to libretro, C++98-compatible variant"
HOMEPAGE="https://github.com/libretro/bsnes-libretro"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/bsnes-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="profile_accuracy +profile_balanced profile_performance"

REQUIRED_USE="^^ ( profile_accuracy profile_balanced profile_performance )"

RDEPEND=""

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-makefile.patch
}

src_compile() {
	local myprofile

	if use profile_accuracy; then
		myprofile="accuracy"
	elif use profile_balanced; then
		myprofile="balanced"
	else
		myprofile="performance"
	fi

	emake profile=${myprofile} \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install || die
}
