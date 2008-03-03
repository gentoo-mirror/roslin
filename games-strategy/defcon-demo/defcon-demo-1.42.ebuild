# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PN=defcon
MY_PV=${PV/_/-}
MY_P=defcon-v${MY_PV}

DESCRIPTION="Global thermonuclear war simulation with multiplayer support"
HOMEPAGE="http://www.introversion.co.uk/defcon/"
SRC_URI="http://download.introversion.co.uk/defcon/linux/${MY_P}.tar.gz"

# See license.txt
LICENSE=${PN}
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dynamic"
RESTRICT="strip"

# glibc discussion:
# http://forums.introversion.co.uk/defcon/viewtopic.php?t=4016
RDEPEND=">=sys-libs/glibc-2.3
	x86? (
		dynamic? (
			media-libs/libogg
			media-libs/libsdl
			media-libs/libvorbis )
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXext
		x11-libs/libXdmcp )
	amd64? ( >=app-emulation/emul-linux-x86-sdl-2.3-r1 )"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}" || die

	# FindPath scripts are ugly and unnecessary
	rm defcon doc/README-SDL.txt
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r * || die

	exeinto "${dir}"/lib
	doexe lib/*.{sh,x86} || die
	if use dynamic ; then
		rm "${D}/${dir}"/lib/lib*
	else
		doexe lib/lib* || die
	fi

	# Can be upgraded to full version, so is not installed as "demo"
	games_make_wrapper ${MY_PN} lib/defcon.bin.x86 "${dir}" "${dir}"/lib
	make_desktop_entry ${MY_PN} "Defcon"

	prepgamesdirs
}
