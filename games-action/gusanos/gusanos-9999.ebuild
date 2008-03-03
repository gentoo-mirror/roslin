# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools cvs games

WIN_PV="0.9c"

DESCRIPTION="Clone of Liero - described as real-time Worms or 2D Quake"
HOMEPAGE="http://gusanos.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${WIN_PV}.zip"

ECVS_SERVER="${PN}.cvs.sourceforge.net:/cvsroot/${PN}"
ECVS_MODULE="./"
# Forces sensible directory under ${S}
ECVS_LOCALNAME=${PN}

LICENSE="GPL-2"
SLOT="0"
# Does not work on amd64 - http://comser.robal.org/forum/index.php?topic=498.0
KEYWORDS="-* ~x86"
IUSE=""

RDEPEND=">=media-libs/allegro-4.2.0
	media-libs/libpng
	>=dev-libs/boost-1.33.1-r1
	>=media-libs/fmod-3.74
	=net-libs/zoidcom-0.6.5"
DEPEND="${RDEPEND}
	dev-util/cvs
	dev-util/re2c
	dev-util/scons
	app-arch/unzip"

S=${WORKDIR}/${PN}

pkg_setup() {
	games_pkg_setup

	if ! built_with_use "dev-libs/boost" threads ; then
		die "Re-emerge dev-libs/boost with 'threads' USE flag."
	fi
}

src_unpack() {
	unpack ${A}
	cvs_src_unpack
	cd "${S}"

	# Fixes sandbox violations
	sed -i \
		-e "s:env = MyEnv():env = MyEnv()\nenv.SConsignFile():" \
		SConstruct || die "sed SConstruct failed"

	# Fixes compilation error:
	# Goop/player_options.h:39: error: extra qualification 'PlayerOptions::' on member 'setTeam'
	sed -i \
		-e "s/PlayerOptions:://" \
		Goop/player_options.h || die "sed player_options.h failed"
}

src_compile() {
	scons || die "scons failed"
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}
	insinto "${dir}"
	doins -r "${WORKDIR}"/default || die "doins default failed"

	newgamesbin bin/posix/${PN} ${PN}.bin || die "newgamesbin failed"
	games_make_wrapper ${PN} ${PN}.bin "${dir}"
	make_desktop_entry ${PN} "Gusanos"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "Documentation:  http://gusanos.sourceforge.net/docs/"
	echo
}
