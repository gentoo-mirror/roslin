# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

QWPN="${PN/quake/qw}"

inherit eutils git games

DESCRIPTION="Conservative Quake 1 engine"
HOMEPAGE="http://disenchant.net/engine.html"
SRC_URI=""

EGIT_REPO_URI="git://disenchant.net/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X cdinstall debug dedicated opengl qwclient"

S=${WORKDIR}/engine
dir=${GAMES_DATADIR}/quake1

# These dependencies have not been checked
COMMON="media-libs/alsa-lib
	media-libs/jpeg
	media-libs/libogg
	media-libs/libpng
	media-libs/libvorbis
	net-libs/gnutls
	virtual/opengl
	media-libs/libsdl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm"
RDEPEND="${COMMON}
	cdinstall? ( games-fps/quake1-data )"
DEPEND="${COMMON}
	dev-util/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"

src_unpack() {
	#unpack ${A}
	git_src_unpack
	cd "${S}"

}

# Split the build
src_compile() {
	yesno() { useq $1 && echo Y || echo N ; }

	local apps
	use dedicated && apps="${apps} tyr-qwsv"
	use X && apps="${apps} tyr-quake"
	use qwclient && apps="${apps} tyr-qwcl"
	if use opengl; then
		if use qwclient; then
			apps="${apps} tyr-glqwcl"
		fi
		apps="${apps} tyr-glquake"
	fi

	emake prepare || die "emake prepare failed"

	emake \
		USE_X86_ASM=$(yesno x86) \
		DEBUG=$(yesno debug) \
		QBASEDIR="${dir}" \
		STRIP=echo \
		${apps} \
		|| die "emake ${apps} failed"
}


src_install() {
	dogamesbin tyr-* || die "dogamesbin failed"
	
	if use opengl; then
		if use qwclient; then
			games_make_wrapper ${QWPN} "./tyr-glqwcl -mem 32" "${GAMES_BINDIR}"
		fi
		games_make_wrapper ${PN} "./tyr-glquake -mem 32" "${GAMES_BINDIR}"
	elif use X; then
		if use qwclient; then
			games_make_wrapper ${QWPN} "./tyr-qwcl -mem 32" "${GAMES_BINDIR}"
		fi
		games_make_wrapper ${PN} "./tyr-quake -mem 32" "${GAMES_BINDIR}"
	fi

	dodoc readme.txt

	prepgamesdirs
}
