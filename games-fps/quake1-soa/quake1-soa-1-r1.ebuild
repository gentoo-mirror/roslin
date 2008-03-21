# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Scourge of Armagon"
MOD_CMDLINE_OPTIONS="-hipnotic"
MOD_DEPEND_UNZIP=n

inherit eutils games games-mod

DESCRIPTION="Scourge of Armagon mission pack for Quake 1"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake-mp1/"

IUSE="vispatch"
SRC_URI="vispatch? ( mirror://sourceforge/vispatch/hipnotic_vis.tgz )"
#		ftp://ftp.lublin.pl/vol/8/planetquake/qng/hipnotic.zip
#		http://shub-hub.com/idgames2/planetquake/qng/hipnotic.zip

DEPEND="vispatch? ( games-util/vispatch )"

# See manual.txt for license

pkg_setup() {
	games_pkg_setup

	cdrom_get_cds Armagon/HIPNOTIC/PAK0.PAK:hipnotic/pak0.pak
}

src_unpack() {
	if use vispatch; then
		unpack ${A}
		mkdir hipnotic
		cp "${CDROM_ROOT}/${CDROM_MATCH}" hipnotic/pak0.pak
		mv HIPNOTIC.VIS hipnotic.vis
		vispatch -dir ${S}/hipnotic -data ${S}/hipnotic.vis || die "vispatch failed"
	fi
}

src_install() {
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
