# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib games

DESCRIPTION="An easy, self-contained Sony Playstation emulator"
HOMEPAGE="http://psxemulator.gazaxian.com/"
SRC_URI="http://psxemulator.gazaxian.com/pSX_linux_${PV/./_}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/${PN}/pSX"
QA_PRESTRIPPED="${GAMES_PREFIX_OPT:1}/${PN}/pSX"

DEPEND=""

RDEPEND="dev-libs/libxml2[abi_x86_32(-)]
	virtual/opengl[abi_x86_32(-)]
	media-libs/alsa-lib[abi_x86_32(-)]
	>=x11-libs/gtk+-2.10.14:2[abi_x86_32(-)]
	x11-libs/gtkglext[abi_x86_32(-)]
	>=gnome-base/libglade-2.0[abi_x86_32(-)]
	>=dev-libs/expat-2.0[abi_x86_32(-)]
	sys-libs/zlib[abi_x86_32(-)]"

S="${WORKDIR}/pSX"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"

	games_pkg_setup
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}"/${PN}

	insinto "${dir}"
	doins -r pSX bios cdimages || die "doins failed"
	fperms a+x "${dir}/pSX"
	games_make_wrapper psx ./pSX "${dir}"
	make_desktop_entry psx pSX
	keepdir "${dir}"/{bios,cdimages}
	dodoc readme.txt
	prepgamesdirs
}
