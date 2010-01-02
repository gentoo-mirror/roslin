# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator games

MY_PN=${PN#quake1-}
MY_PV=$(get_version_component_range 1-1)-$(get_version_component_range 2-2)-r$(get_version_component_range 3-3)

DESCRIPTION="Collection of 104 single-player Quake 1 maps with an intro map"
HOMEPAGE="http://www.quakeone.com/index.php?ind=downloads&op=view_file&file_id=164"
SRC_URI="${MY_PN}-${MY_PV}.7z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="darkplaces"
RESTRICT="fetch strip"

# quake1-demodata is not sufficient
RDEPEND="games-fps/quake1-data
	darkplaces? ( games-fps/darkplaces )"
DEPEND="app-arch/p7zip"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download ${A} from:"
	einfo "${DOWNLOAD_URL}"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	unpack ${A}

	rm *.exe fitz*.txt readmegl.txt
}

src_install() {
	insinto "${GAMES_DATADIR}"/quake1
	doins -r * || die "doins -r failed"

	if use darkplaces ; then
		games_make_wrapper darkplaces-${MY_PN} \
			"darkplaces -game ${MY_PN} +map ${MY_PN}"
		make_desktop_entry darkplaces-${MY_PN} \
			"Dark Places - Undergate" darkplaces.png
	fi

	prepgamesdirs
}
