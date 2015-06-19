# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Conservative Quake 1 engine"
HOMEPAGE="http://disenchant.net/engine.html"
SRC_URI="http://disenchant.net/files/engine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdinstall debug opengl"

dir=${GAMES_DATADIR}/quake1

# These dependencies have not been checked
COMMON="media-libs/alsa-lib
	virtual/opengl
	media-libs/libsdl
	x11-libs/libX11
	x11-libs/libXxf86vm
	x11-libs/libXxf86dga"
RDEPEND="${COMMON}
	cdinstall? ( games-fps/quake1-data )"
DEPEND="${COMMON}
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"

src_compile() {
	yesno() { useq $1 && echo Y || echo N ; }

	local apps
	apps="tyr-quake"
	if use opengl || [[ -z "${apps}" ]] ; then
		apps="${apps} tyr-glquake"
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
	if use opengl; then
		newgamesbin tyr-glquake ${PN} || die "newgamesbin failed"
		newgamesbin tyr-quake ${PN}.x11 || die "newgamesbin failed"
	else
		newgamesbin tyr-quake ${PN} || die "newgamesbin failed"
	fi

	dodoc readme.txt || die "dodoc failed"

	prepgamesdirs
}
