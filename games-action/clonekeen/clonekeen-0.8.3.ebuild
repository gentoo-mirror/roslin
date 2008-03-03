# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator games 

MY_PV="$(get_version_component_range 2-3)" 
MY_PV="Beta${MY_PV/./}" 

DESCRIPTION="Clone of Commander Keen platform game" 
HOMEPAGE="http://clonekeen.sourceforge.net/" 

SRC_URI="mirror://sourceforge/${PN}/CK${MY_PV}_Src.zip 
   mirror://sourceforge/${PN}/CK${MY_PV}_Bin_W32.zip" 
# Pity we can't use ftp://ftp.3drealms.com/share/1keen.zip 
LEVELS_URI="http://www.spatang.com/dl.php?a=1keen131&b=orig" 

# Shareware level data is free-noncomm 
LICENSE="GPL-2 
	free-noncomm"

SLOT="0" 
KEYWORDS="~amd64 ~x86" 
IUSE="" 
RESTRICT="nostrip" 

RDEPEND=">=dev-libs/DirectFB-0.9.22 
   >=media-libs/libsdl-1.2.8-r1
   || ( 
      ( 
		x11-libs/libX11
		x11-libs/libXau 
		x11-libs/libXdmcp 
		x11-libs/libXext ) 
		virtual/x11 )" 
DEPEND="${RDEPEND} 
    app-arch/unzip"

S=${WORKDIR}/keen/src 
dir=${GAMES_DATADIR}/${PN} 
logfile=${dir}/ck.log 

src_unpack() {
	unpack ${A} || die 

	cd ${WORKDIR}/keen/bin/data/ 
	# It's bad to download here, but necessary due to URL format 
	wget -O levels.zip "${LEVELS_URI}" || die 
	unzip levels.zip || die 
}

src_compile() { 
	mv Makefile.lnx Makefile 

	# Info from http://forums.gentoo.org/viewtopic.php?t=135866 
	sed -i sdl/{key,snd,time,vid}drv.c \ 
		-e "s:<SDL:<SDL/SDL:" || die "sed SDL failed" 

	# Clean scale2x dir 
	emake clean 
	emake -j1 || die
}

src_install() { 
	insinto "${dir}" 
    touch "${WORKDIR}"/keen/bin/ck.log 
	doins -r "${WORKDIR}"/keen/bin/* || die 

	newgamesbin keen ${PN}.bin || die 
	games_make_wrapper ${PN} ${PN}.bin "${dir}" 

    dodoc *.txt 

	prepgamesdirs 

    # Need to be able to write to the dir 
	fperms 770 "${dir}" || die 

	# Special file, must be writable by all players 
	fperms 660 "${dir}/ck.log" || die 
}

pkg_postinst() { 
	einfo "To play the game:   ${PN} -dbl" 
    einfo "For other options:  ${PN} -?" 
	echo 

	games_pkg_postinst 
}
