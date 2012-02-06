# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib git-2

DESCRIPTION="Self-contained Super Nintendo emulation core, C++98 variant"
HOMEPAGE="https://github.com/Themaister/libsnes"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/libsnes.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="profile_accuracy +profile_compatibility profile_performance"

REQUIRED_USE="^^ ( profile_accuracy profile_compatibility profile_performance )"

RDEPEND=""

DEPEND="!dev-games/libsnes
	!dev-games/snes9x-libsnes"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-082-makefile.patch

	sed -i "snes/Makefile" \
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
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install || die
}
