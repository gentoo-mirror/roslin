# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games git

DESCRIPTION="Conservative Quake 1 engine, QuakeWorld client/server"
HOMEPAGE="http://disenchant.net/engine.html"
SRC_URI=""

EGIT_REPO_URI="git://disenchant.net/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X cdinstall debug dedicated opengl server"

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

pkg_setup() {
	games_pkg_setup

	if use server && use dedicated; then
		einfo "Can't build with \"server\" and \"dedicated\" USE flags."
		einfo "Disable one of them and restart the merge"
		die "\"server\" and \"dedicated\" USE flags enabled."
	fi
}

src_compile() {
	yesno() { useq $1 && echo Y || echo N ; }

	local apps
	use X && apps="tyr-qwcl"
	if use dedicated || use server; then
		apps="${apps} tyr-qwsv"
	fi
	if use opengl || [[ -z "${apps}" ]]; then
		apps="${apps} tyr-glqwcl"
	fi

	emake prepare || die "emake prepare failed"

	emake \
		USE_X86_ASM=$(yesno x86) \
		DEBUG=$(yesno debug) \
		QBASEDIR="${dir}" \
		STRIP=echo \
		V=1 \
		${apps} \
		|| die "emake ${apps} failed"
}

src_install() {
	if use opengl && use X; then
		newgamesbin tyr-glqwcl ${PN} || die "newgamesbin failed"
		newgamesbin tyr-qwcl ${PN}.x11 || die "newgamesbin failed"
	elif use !opengl && use X; then
		newgamesbin tyr-qwcl ${PN} || die "newgamesbin failed"
	fi

	if use dedicated || use server; then
		newgamesbin tyr-qwsv ${PN}.srv || die "newgamesbin failed"
	fi

	dodoc readme.txt || die "dodoc failed"

	prepgamesdirs
}
