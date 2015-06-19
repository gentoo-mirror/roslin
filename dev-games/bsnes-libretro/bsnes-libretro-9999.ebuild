# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib git-2

DESCRIPTION="bsnes emulation core ported to libretro"
HOMEPAGE="http://gitorious.org/bsnes/bsnes"
SRC_URI=""

EGIT_REPO_URI="git://gitorious.org/bsnes/bsnes.git"
EGIT_BRANCH="libretro"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="profile_accuracy +profile_compatibility profile_performance"

REQUIRED_USE="^^ ( profile_accuracy profile_compatibility profile_performance )"

RDEPEND=""

DEPEND=""

S="${WORKDIR}/bsnes"

src_unpack() {
	S="${WORKDIR}" git-2_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-makefile.patch

	sed -i "target-libretro/Makefile" \
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

	emake profile=${myprofile} \
		target=libretro \
		compiler=gcc \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr target=libretro install || die
}
