# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Turn-based fantasy strategy game, precursor to the Dominions series"
HOMEPAGE="http://www.shrapnelgames.com/Illwinter/CoE2/"
SRC_URI="http://download.shrapnelgames.com/downloads/${PN}_${PV}.zip"

LICENSE="as-is"
SLOT="0"
# Should work on amd64 (untested)
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libsdl"

S=${WORKDIR}/coe
dir=${GAMES_PREFIX_OPT}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm *.{dll,exe}
	rm -r old

	mv -f coe_linux{,64bit} "${T}" || die
}

src_install() {
	insinto "${dir}"
	doins -r * || die "doins"

	local exe=coe_linux
	use amd64 && exe=coe_linux64bit

	exeinto "${dir}"
	doexe "${T}/${exe}" || die "doexe"

	games_make_wrapper ${PN} "./${exe}" "${dir}"
	make_desktop_entry ${PN} "Conquest of Elysium 2"

	# Slots for saved games.
	# The game shows e.g. "EMPTY SLOT 0?", but it works.
	local f slot state_dir=${GAMES_STATEDIR}/${PN}
	dodir "${state_dir}"
	for slot in {0..4} ; do
		f=save${slot}
		dosym "${state_dir}/save${slot}" "${dir}/${f}" || die "dosym"
		echo "empty slot ${slot}" > "${D}${state_dir}/${f}" || die "echo"
		fperms 660 "${state_dir}/${f}" || die "fperms"
	done

	prepgamesdirs
}
