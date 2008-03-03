# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator games

MY_PV=$(delete_all_version_separators)
MY_P=${PN}-v${MY_PV}
FILE=${MY_P}-linux
DEBIAN_PATCH="supertransball2_${PV}-3.diff"

DESCRIPTION="Thrust clone"
HOMEPAGE="http://www.braingames.getput.com/stransball2/"
SRC_URI="http://braingames.bugreport.nl/stransball2/${FILE}.zip
	mirror://debian/pool/main/s/supertransball2/${DEBIAN_PATCH}.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=media-libs/freetype-2.1.10
	>=media-libs/libsdl-1.2.8-r1
	>=media-libs/sdl-image-1.2.3-r1
	>=media-libs/sdl-mixer-1.2.6
	>=media-libs/sdl-sound-1.0.1-r1
	>=media-libs/sge-030809
	sys-libs/zlib
	|| (
		(
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXext )
		virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${P}/sources
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv "${FILE}" ${P}

	sed -i "${WORKDIR}/${DEBIAN_PATCH}" \
		-e "s:supertransball2:${PN}:" \
		-e "s:/usr/share/games:${GAMES_DATADIR}:" \
		|| die "sed patch failed"

	epatch "${DEBIAN_PATCH}" || die "epatch failed"
	local deb_dir=${WORKDIR}/${P}/debian/patches
	rm "${deb_dir}"/00list
	for p in $(ls -A "${deb_dir}") ; do
		epatch "${deb_dir}"/${p}
	done

	sed -i "${S}"/Makefile \
		-e "s:/usr/local:/usr:" \
		|| die "sed Makefile failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	cd ..
	dogamesbin ${PN} || die "dogamesbin failed"
	make_desktop_entry ${PN} "Super Transball 2"
	dodoc *.txt
	rm -r ${PN} *.txt debian sources

	insinto "${dir}"
	doins -r * || die "doins -r failed"

	prepgamesdirs
}
