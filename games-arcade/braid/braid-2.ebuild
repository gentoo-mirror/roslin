# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

DESCRIPTION="Platform game where you manipulate flow of time"
HOMEPAGE="http://braid-game.com"
SRC_URI="${PN}-linux-build${PV}.run.bin"

LICENSE="braid-unknown-license"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip fetch"

DEPEND="app-arch/unzip"
RDEPEND="media-gfx/nvidia-cg-toolkit
	media-libs/libsdl"

pkg_nofetch() {
	echo
	elog "Download ${SRC_URI} from ${HOMEPAGE} and place it in ${DISTDIR}"
	echo
}


src_unpack() {
	# self unpacking zip archive; unzip warns about the exe stuff
	local a="${DISTDIR}/${A}"
	echo ">>> Unpacking ${a} to ${PWD}"
	unzip -q "${a}"
	[ $? -gt 1 ] && die "unpacking failed"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	doins -r data/gamedata/data || die "doins failed"
	doexe data/x86/"${PN}" || die "doexe failed"
	doicon data/gamedata/"${PN}.png" || die "doicon failed"

	dodoc data/gamedata/README-linux.txt || die "dodoc failed"

	games_make_wrapper "${PN}" "./${PN}" "${dir}" || die
	make_desktop_entry "${PN}" "Braid" || die

	prepgamesdirs
}
