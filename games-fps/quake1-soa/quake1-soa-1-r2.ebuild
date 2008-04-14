# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Scourge of Armagon"
MOD_CMDLINE_OPTIONS="-hipnotic"
use !lights && MOD_DEPEND_UNZIP=n

inherit eutils games games-mod

DESCRIPTION="Scourge of Armagon mission pack for Quake 1"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake-mp1/"

IUSE="lights vispatch"
SRC_URI="vispatch? ( mirror://sourceforge/vispatch/hipnotic_vis.tgz )
	lights? ( http://www.kgbsyndicate.com/romi/soa.zip )"

DEPEND="vispatch? ( games-util/vispatch )"

# See manual.txt for license

dir=${GAMES_DATADIR}/quake1

pkg_setup() {
	games_pkg_setup

	cdrom_get_cds Armagon/HIPNOTIC/PAK0.PAK:hipnotic/pak0.pak
}

src_unpack() {
	if use vispatch; then
		cd "${S}"
		unpack hipnotic_vis.tgz
		mkdir hipnotic
		cp "${CDROM_ROOT}/${CDROM_MATCH}" "${S}"/hipnotic/pak0.pak
		vispatch -dir "${S}"/hipnotic -data "${S}"/hipnotic.vis || die "vispatch failed"
	fi

	if use lights; then
		cd "${S}"
		unpack soa.zip
		mkdir -p hipnotic/maps
		mv *rtlights hipnotic/maps
	fi
}

src_install() {
	insinto "${dir}"/hipnotic/maps
	use lights && doins "${S}"/hipnotic/maps/* \
		|| die "newins lights failed"

	insinto "${dir}"/hipnotic
	if use vispatch; then
		newins "${S}"/hipnotic/pak0.pak pak0.pak \
			|| die "newins ${S}/hipnotic/pak0.pak failed"
	else
		newins "${CDROM_ROOT}/${CDROM_MATCH}" pak0.pak \
			|| die "newins ${CDROM_MATCH} failed"
	fi

	# CDROM_SET starts at 0
	if [[ "${CDROM_SET}" = "0" ]] ; then
		dodoc "${CDROM_ROOT}"/Armagon/*.{TXT,txt}
	else
		dodoc "${CDROM_ROOT}"/*.txt
	fi

	games-mod_src_install_tidy

	prepgamesdirs
}
