# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib games

DESCRIPTION="An accuracy-focused Sega Genesis/MegaDrive/Master System/Game Gear/SC-3000/SG-1000 emulator"
HOMEPAGE="http://aamirm.hacking-cult.org/index_files/regen.htm"
SRC_URI="http://aamirm.hacking-cult.org/regen/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

QA_PRESTRIPPED="${GAMES_PREFIX_OPT:1}/bin/regen"

S="${WORKDIR}"

DEPEND=""

RDEPEND="
	|| (
		(
			x11-libs/gtk+:2[abi_x86_32(-)]
			media-libs/alsa-lib[abi_x86_32(-)]
			media-libs/libsdl[joystick,abi_x86_32(-)]
			sys-libs/zlib[abi_x86_32(-)]
			x11-libs/libXrandr[abi_x86_32(-)]
			x11-libs/libXv[abi_x86_32(-)]
			virtual/opengl[abi_x86_32(-)]
		)

		amd64? (
			app-emulation/emul-linux-x86-gtklibs[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-soundlibs[alsa,-abi_x86_32(-)]
			app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-opengllibs[-abi_x86_32(-)]
		)
	)
"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"

	games_pkg_setup
}

src_install() {
	exeinto "${GAMES_PREFIX_OPT}"/bin
	doexe regen || die "doexe failed"
	dodoc README || die "dodoc failed"

	make_desktop_entry regen "Regen"

	prepgamesdirs
}
