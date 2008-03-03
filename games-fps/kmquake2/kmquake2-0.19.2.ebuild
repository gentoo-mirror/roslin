# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs flag-o-matic toolchain-funcs games

MY_PN="quake2"
FILE_STEM="KMQuake2-SDL-${PV}_src_unix"
DATA_STEM="KMQuake2_data-0.19"
QUDOS_SRC="http://qudos.quakedev.com/linux/quake2/engines/KMQuake2"

DESCRIPTION="Enhanced Quake 2 engine with Lazarus mod support"
HOMEPAGE="http://qexpo2005.quakedev.com/booths.php?tag=knightmare
	http://qudos.quakedev.com/"
SRC_URI="${QUDOS_SRC}/${FILE_STEM}.tar.bz2
	${QUDOS_SRC}/${DATA_STEM}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa audacious cdinstall cdsound debug dedicated demo dga maps mods opengl oss optimize-cflags sdl textures"

QA_EXECSTACK="${GAMES_BINDIR:1}/${PN}"

UIRDEPEND="alsa? ( media-libs/alsa-lib )
	audacious? ( media-sound/audacious )
	media-libs/jpeg
	media-libs/libogg
	media-libs/libpng
	media-libs/libvorbis
	virtual/opengl
	virtual/glu
	sdl? ( media-libs/libsdl )
	x11-libs/libX11
	x11-libs/libXext
	dga? ( x11-libs/libXxf86dga )
	x11-libs/libXxf86vm"
UIDEPEND="${UIRDEPEND}
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
RDEPEND="opengl? ( ${UIRDEPEND} )
	!opengl? ( sdl? ( ${UIRDEPEND} ) )
	!opengl? ( !sdl? ( !dedicated? ( ${UIRDEPEND} ) ) )
	cdinstall? ( games-fps/quake2-data )
	demo? ( games-fps/quake2-demodata )
	maps? ( games-fps/kmquake2-shanmaps )
	mods? ( games-fps/kmquake2-mods )
	textures? ( games-fps/quake2-textures )"
DEPEND="opengl? ( ${UIDEPEND} )
	!opengl? ( sdl? ( ${UIDEPEND} ) )
	!opengl? ( !sdl? ( !dedicated? ( ${UIDEPEND} ) ) )
	app-arch/unzip"

S=${WORKDIR}/${FILE_STEM}
dir=${GAMES_DATADIR}/${MY_PN}
libdir=${GAMES_LIBDIR}/${PN}

build_client() {
	if use opengl || use sdl || ! use dedicated ; then
		# Build default client
		return 0
	fi
	return 1
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix for amd64 - http://bugs.gentoo.org/show_bug.cgi?id=158415
	sed -i \
		-e "s:\#include <sys/types\.h>:\#define _GNU_SOURCE\n\#include <sys/types\.h>:" \
		unix/qsh_unix.c || die "sed qsh_unix.c failed"

	# Fix directory search for the game API
	sed -i \
		-e 's:"%s/%s/%s", curpath, path, gamename:"%s/%s", path, gamename:' \
		unix/sys_unix.c || die "sed sys_unix.c failed"

	# Fix Makefile for "optimize" USE flag
	local march=$(get-flag -march)
	sed -i \
		-e "s:-march=\$(MACHINE):${march}:" \
		Makefile || die "sed Makefile failed"

	if [[ "$(gcc-fullversion)" == "4.1.1" ]] ; then
		# Needs -O0 to stop audio corruption with shotgun
		sed -i \
			-e "s:-O3:-O0:" \
		Makefile || die "sed Makefile -O0 failed"
	fi

	if build_client ; then
		if use alsa && ! use oss ; then
			ewarn "The ALSA sound driver for this game is incomplete."
			ewarn "The 'oss' USE flag is recommended instead."
			echo
			# Change default from OSS to ALSA
			sed -i \
				-e "s:\"sndalsa\", \"0\":\"sndalsa\", \"1\":" \
				unix/snd_unix.c || die "sed snd_alsa.c failed"
		fi

		if ! use cdsound ; then
			# Disable checking of the CD drive
			sed -i \
				-e "s:/dev/cdrom:/dev/null:" \
				-e "s:\"nocdaudio\", \"0\":\"nocdaudio\", \"1\":" \
				-e "s:\"cd_nocd\", \"0\":\"cd_nocd\", \"1\":" \
				unix/cd_unix.c || die "sed cd_unix.c failed"
		fi
	fi

	rm gnu.txt
	mv "${WORKDIR}/${DATA_STEM}/${PN}.png" "${WORKDIR}"
}

src_compile() {
	yesno() { useq $1 && echo YES || echo NO ; }

	local target="release"
	use debug && target="debug"

	local opengl="NO" sdl="NO"
	if build_client ; then
		if use sdl ; then
			sdl="YES"
		else
			opengl="YES"
		fi
	fi

	# Prevent potential for "signal 11" abort, requested by QuDos
	filter-flags -fomit-frame-pointer

	emake \
		BUILD_DEDICATED=$(yesno dedicated) \
		BUILD_KMQUAKE2=${opengl} \
		BUILD_KMQUAKE2_SDL=${sdl} \
		WITH_AUDACIOUS=$(yesno audacious) \
		WITH_XMMS=NO \
		DATADIR="${dir}" \
		LIBDIR="${libdir}" \
		OPTIMIZE=$(yesno optimize-cflags) \
		WITH_XF86_DGA=$(yesno dga) \
		LOCALBASE="/usr" \
		CC="$(tc-getCC)" \
		BUILD_DATADIR=YES \
		BUILD_LIBDIR=YES \
		"${target}" \
		|| die "emake failed"
}

src_install() {
	local icon=${PN}.png

	insinto "${libdir}"
	doins -r "${WORKDIR}/${DATA_STEM}"/* \
		|| die "doins ${DATA_STEM} failed"
	doins -r quake2/baseq2 \
		|| die "doins quake2/baseq2 failed"

	doicon "${WORKDIR}/${icon}" || die "doicon failed"

	if build_client ; then
		if use sdl ; then
			newgamesbin ${MY_PN}/${PN}-sdl ${PN} \
				|| die "newgamesbin ${PN}-sdl failed"
		else
			dogamesbin ${MY_PN}/${PN} \
				|| die "dogamesbin ${PN} failed"
		fi

		if use demo ; then
			games_make_wrapper ${PN}-demo "${PN} +set game demo"
			make_desktop_entry ${PN}-demo "KM Quake 2 (Demo)" "${icon}"
		else
			make_desktop_entry ${PN} "KM Quake 2" "${icon}"
		fi
	fi

	if use dedicated ; then
		newgamesbin ${MY_PN}/${PN}_netserver ${PN}-ded \
			|| die "newgamesbin ${PN}_netserver failed"
	fi

	dodoc *.{txt,unix}

	prepgamesdirs
}
