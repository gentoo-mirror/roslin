# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator rpm games

MY_PN="oolite"
MY_PV=$(replace_version_separator 2 '-')
MY_PV=${MY_PV/beta/dev}
# Latest version is in ftp://ftp.alioth.net/oolite/
ADDON_URL="http://capnhack.com/hosting/oolite/Oolite"
ALIOTH="ftp://ftp.alioth.net/oolite"

DESCRIPTION="Elite space trading & warfare remake"
HOMEPAGE="http://oolite.aegidian.org/"
SRC_URI="${ALIOTH}/oolite-${MY_PV}-data.tar.gz
	${ALIOTH}/Oolite-Linux-${MY_PV}-x86.tar.gz
	mildsound? ( ${ADDON_URL}/extra/oosounds3.zip )
	kleptohud? ( http://capnhack.com/hosting/oolite/Oolite/OXPs/kleptohud.oxp.zip )
	amigasound? ( ${ADDON_URL}/OXPs/E5Amigasoundpack01oxp.zip )
	amd64? (
		mirror://debian/pool/main/liba/libart-lgpl/libart-2.0-2_2.3.17-1_i386.deb
		ftp://xmlsoft.org/libxslt/libxslt-1.1.20-1.i386.rpm )"

# This particular licence isn't in Portage yet
LICENSE="CCPL-Attribution-NonCommercial-ShareAlike-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip"
# Many add-ons at http://capnhack.com/hosting/oolite/Oolite/OoSat.html
IUSE="amigasound kleptohud mildsound"

RDEPEND="virtual/opengl
	x86? (
		>=media-libs/libsdl-1.2.8-r1
		>=media-libs/sdl-gfx-2.0.13-r1
		>=media-libs/sdl-image-1.2.3-r1
		>=media-libs/sdl-mixer-1.2.6
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext )
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-10.1
		>=app-emulation/emul-linux-x86-sdl-2.3
		app-emulation/emul-linux-x86-xlibs )"
DEPEND="app-arch/unzip
	!games-strategy/oolite"

S=${WORKDIR}/oolite-installer
dir=${GAMES_PREFIX_OPT}/Oolite

QA_EXECSTACK="${dir:1}/oolite-deps/lib/libcallback.so.0
	${dir:1}/oolite-deps/lib/libavcall.so.0
	${dir:1}/oolite-deps/lib/libSDL-1.2.so.0"
QA_TEXTRELS="${dir:1}/oolite-deps/lib/libSDL-1.2.so.0"

src_unpack() {
	rpm_src_unpack
	if use amd64 ; then
		unpack ./data.tar.gz
	fi
	cd "${S}"

	sed -i \
		-e "s:/usr/local:${D}opt:" \
		-e "s:\$INSTALLDIR/bin:${D}${GAMES_PREFIX_OPT}/\$TOPLEVEL/bin:" \
		-e "s:OOLITE_ROOT=\$INSTALLDIR:OOLITE_ROOT=${GAMES_PREFIX_OPT}:" \
		install || die "sed install"
}

src_install() {
	local oxp_dir=${dir}/AddOns

	dodir "${dir}"/bin
	./install systemwide || die "install"

	if use amd64 ; then
		# Install 32-bit libs
		# emul-linux-x86-baselibs-10.1 provides libxml2
		dodir /usr/lib32
		cp -a "${WORKDIR}"/usr/lib/* "${D}/usr/lib32" || die "cp lib32"
	fi

	# Remove updater program
	rm "${D}/${dir}"/bin/oolite-update

	# Remove unnecessary libraries which revdep-rebuild would moan about
	rm -r "${D}/${dir}"/oolite-deps/GNUstep/System/Library/Bundles/{GSPrinting,SSL.bundle}

	# Add-on packs - http://wiki.alioth.net/index.php/OXP
	insinto "${oxp_dir}"
	if use mildsound ; then
		# Install OXP pack
		doins -r "${WORKDIR}"/oosounds3/* \
			|| die "doins mildsound"
	fi
	if use amigasound ; then
		cd "${WORKDIR}"/E5Amigasoundpack01oxp
		mv -f readme.txt e5amigasoundpack.oxp/
		cd e5amigasoundpack.oxp/Music
		# The two files are identical, so replace one with a symlink
		ln -sf BlueDanube.ogg OoliteTheme.ogg || die "ln amigasound"
		cd "${S}"
		doins -r "${WORKDIR}"/E5Amigasoundpack01oxp/* \
			|| die "doins amigasound"
	fi
	if use kleptohud ; then
		# http://oosat.alioth.net/node/31
		doins -r "${WORKDIR}"/kleptohud.oxp/* \
			|| die "doins kleptohud"
	fi

	# Use wrapper for pre-compiled binary
	doicon "${D}/${dir}/oolite.app/Contents/Resources/Textures/oolite-logo.png" \
		|| die "doicon"
	games_make_wrapper ${MY_PN} "${dir}/bin/${MY_PN}" "${dir}"
	make_desktop_entry ${MY_PN} "Oolite" oolite-logo

	prepgamesdirs
}
