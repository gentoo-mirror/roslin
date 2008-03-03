# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

MY_PN="porrasturvat"

DESCRIPTION="Push a ragdoll down the stairs with different forces and angles"
HOMEPAGE="http://jet.ro/dismount/"
SRC_URI="http://koti.mbnet.fi/jjl/files/${MY_PN}-${PV}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	sys-libs/glibc
	sys-libs/zlib
	virtual/opengl
	|| (
		(
			media-libs/mesa
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXext )
			virtual/x11 )"
DEPEND=""

S=${WORKDIR}/${MY_PN}
dir=${GAMES_PREFIX_OPT}/${MY_PN}

src_install() {
	insinto "${dir}"
	exeinto "${dir}"

	doexe porrasturvat{,.bin} || die "doexe failed"
	rm porrasturvat{,.bin}

	doins -r * || die "doins failed"

	games_make_wrapper ${MY_PN} "${dir}/${MY_PN}" "${dir}" "${dir}"

	# Set up links for writeable files
	local statedir=${GAMES_STATEDIR}/${MY_PN}
	dodir "${statedir}"
	for filename in scores.dat ; do
		touch "${D}${statedir}/${filename}" || die
		dosym "${statedir}/${filename}" "${dir}/${filename}" || die
		fperms 660 "${statedir}/${filename}" || die
	done

	prepgamesdirs
}
