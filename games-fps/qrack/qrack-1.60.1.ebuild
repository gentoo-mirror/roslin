# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs flag-o-matic games

MY_WINDOWS="${PN}160.zip"
MY_URL="http://www.quakeone.com/${PN}"

# Qrack used to be called JoeQuake Pro
DESCRIPTION="Quake 1 engine based on ProQuake and JoeQuake"
HOMEPAGE="http://www.quakeone.com/qrack/
	http://qudos.quakedev.com/linux/quake1/"
SRC_URI="http://qudos.quakedev.com/linux/quake1/${P}-src.tar.bz2
	${MY_URL}/${MY_WINDOWS}
	${MY_URL}/pak1.zip
	${MY_URL}/pak2.zip
	lights? ( http://www.fuhquake.net/files/extras/fuhquake-lits.rar )"

LICENSE="GPL-2"
SLOT="0"
# Has assembler code in e.g. gl_draw.c
KEYWORDS="~x86"
IUSE="debug doe dzip lights sdl skins soa textures"

UIRDEPEND="media-libs/libpng
	sdl? ( media-libs/libsdl )
	virtual/jpeg
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
UIDEPEND="x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
# Is not quite compatible with the demo data
RDEPEND="${UIRDEPEND}
	games-fps/quake1-data
	doe? ( games-fps/quake1-doe )
	skins? ( games-fps/quake1-skins )
	soa? ( games-fps/quake1-soa )
	textures? ( >=games-fps/quake1-textures-20050820 )"
DEPEND="${UIRDEPEND}
	${UIDEPEND}
	lights? ( || (
			app-arch/rar
			app-arch/unrar ) )
	app-arch/unzip"

S=${WORKDIR}/${P}-src
dir=${GAMES_DATADIR}/quake1

src_unpack() {
	unpack ${A}
	rm *.exe ${PN}/*.dll

	mkdir -p ${PN}
	mv -f *.pak ${PN} || die "mv *.pak failed"

	if use lights ; then
		mkdir -p ${PN}/lits
		mv -f *.lit ${PN}/lits || die "mv *.lit failed"
	fi

	cd "${S}"

	# Set -march= in Makefile
	local march=$(get-flag -march)
	sed -i \
		-e "s:-march=\$(MARCH):${march}:" \
		Makefile || die "sed Makefile failed"

	if [[ "$(gcc-fullversion)" == "4.1.1" ]] ; then
		# -O1 and higher make the audio crackle
		sed -i \
			-e "s:-O3:-O0:" \
			Makefile || die "sed Makefile -O0 failed"
	fi

	# Save *all* the cvars by default, to easily edit config.cfg
	sed -i \
		-e "s:cfg_savevars\", \"1:cfg_savevars\", \"2:" \
		cvar.c || die "sed cvar.c failed"

	# This works, but is replaced by -nocdaudio on command-line
	#if ! use cdsound ; then
	#	# Turn the CD accesses off
	#	sed -i \
	#		-e "s:/dev/cdrom:/dev/null:" \
	#		cd_unix.c || die "sed cd_unix.c failed"
	#	sed -i \
	#		-e "s:COM_CheckParm(\"-nocdaudio\"):1:" \
	#		cd_{sdl,unix}.c || die "sed nocdaudio failed"
	#fi
}

src_compile() {
	yesno() { useq $1 && echo YES || echo NO ; }

	local target="release" optimize="YES"
	use debug && target="debug" && optimize="NO"

	local opengl="YES"
	use sdl && opengl="NO"

	emake \
		BUILD_QR=${opengl} \
		BUILD_QR_SDL=$(yesno sdl) \
		BUILD_DZIP=$(yesno dzip) \
		OPTIMIZE=${optimize} \
		QR_EXE=${PN} \
		QR_SDL_EXE=${PN}-sdl \
		DATADIR="${dir}" \
		HOMEDIR=".${PN}" \
		LOCALBASE="/usr" \
		CC="$(tc-getCC)" \
		WITH_DATADIR=YES \
		WITH_HOMEDIR=YES \
		VERBOSE=YES \
		STRIP=NO \
		"${target}" \
		|| die "emake failed"
}

src_install() {
	local exe=${PN}
	use sdl && exe=${PN}-sdl
	newgamesbin "quake/${exe}" ${PN} \
		|| die "newgamesbin ${exe} failed"

	if use dzip ; then
		newgamesbin quake/dzip ${PN}-dzip \
			|| die "newgamesbin dzip failed"
	fi

	insinto "${dir}"
	doins -r "${WORKDIR}/${PN}" || die "doins failed"

	make_desktop_entry ${PN} "Qrack"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "To run the game conveniently,"
	elog "set up a ~/bin/qrack script containing e.g.:"
	elog
	elog "exec ${GAMES_BINDIR}/${PN} -width 1024 -height 768 -fullscreen -bpp 32 -44khz -nocdaudio \$@"
	elog
	elog "The easiest way to set up config.cfg is to install joequake, then:"
	elog " cp ~/.joequake/config.cfg ~/.qrack/"
	echo
}
