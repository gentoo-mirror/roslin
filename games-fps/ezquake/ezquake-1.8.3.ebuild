# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic games

DESCRIPTION="Quakeworld client derived from Fuhquake"
HOMEPAGE="http://ezquake.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_linux-x86_${PV}.tar.gz
	mirror://sourceforge/${PN}/${PN}_source_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
# Should also work on amd64 & ppc
KEYWORDS=""
IUSE="cdinstall debug"
RESTRICT="strip"

# glib from http://bugs.gentoo.org/show_bug.cgi?id=163847
UIDEPEND="virtual/opengl
	dev-libs/expat"
#	=dev-libs/glib-1.2*"
RDEPEND="${UIDEPEND}
	cdinstall? ( games-fps/quake1-data )"
DEPEND="${UIDEPEND}
	!games-fps/ezquake-bin
	app-arch/unzip"

S=${WORKDIR}/src
dir=${GAMES_DATADIR}/quake1

QA_EXECSTACK="${GAMES_BINDIR:1}/${PN}"

src_unpack() {
	unpack ${A}
	mv ${PN}_* src || die "mv src"

	# Remove precompiled executables
	rm ${PN}{-gl.glx,.svga,.x11}

	mv qw ${PN} || die
	cd "${S}"

	# Set base directories
	sed -i \
		-e "/ev = getenv(\"HOME\");/i\strlcpy (com_basedir, \"${dir}\", sizeof(com_basedir));" \
		-e "s:strlcpy(com_homedir, com_basedir, sizeof(com_homedir));:strlcpy(com_homedir, ev, sizeof(com_homedir));\nstrlcat(com_homedir, \"/.ezquake\", sizeof(com_homedir));:" \
		-e "/FS_AddGameDirectory(com_basedir, \"qw\");/a\FS_AddGameDirectory(\"${dir}/ezquake\", \"qw\");" \
		common.c || die "sed common.c"

	# Use homedir:  ~/.ezquake/
	sed -i \
		-e 's:"cfg_use_home", "0":"cfg_use_home", "1":' \
		config_manager.c || die "sed config_manager.c"
}

src_compile() {
	local type="release"
	use debug && type="debug"

	# Potential for other targets:  x11 svga
	local target="glx"

	emake \
		TYPE=${type} \
		${target} \
		RELEASE_CFLAGS=${CFLAGS} \
		|| die "emake failed"
}

src_install() {
	local arch="x86"
	use amd64 && arch="x86_64"
	use ppc && arch="ppc"
	local exe_dir="release-${arch}"

	newgamesbin "${exe_dir}/${PN}-gl.glx" ${PN} || die

	insinto "${dir}"
	doins -r "${WORKDIR}"/${PN} || die

	prepgamesdirs
}
