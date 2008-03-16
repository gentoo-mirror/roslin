# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="iD Software's Quake 1 ... the data files"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake/"
SRC_URI="mirror://idsoftware/quake/quake106.zip
	vispatch? (
		http://shub-hub.com/idgames2/planetquake/qng/id1.zip
	)"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="vispatch"

DEPEND="app-arch/lha
	vispatch? ( 
			games-util/vispatch
			app-arch/zip
	)"
RDEPEND=""

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup

	if has_version games-fps/quake1-demodata && \
	   built_with_use "games-fps/quake1-demodata" symlink ; then
		eerror "The symlink for the demo data conflicts with the cdinstall data"
		die "Unmerge games-fps/quake1-demodata to remove the conflict"
	fi
}

src_unpack() {
	export CDROM_NAME_SET=("Existing Install" "Quake CD (1.01)" "Ultimate Quake Collection" "Quake CD (newer)")
	cdrom_get_cds id1:q101_int.1:Setup/ID1:resource.1

	if [[ "${CDROM_SET}" == "1" ]] ; then
		cat "${CDROM_ROOT}"/q101_int.{1,2} > q101_int.x || die "cat"
		lha xfq q101_int.x || die "lha q101_int.x"
	elif [[ "${CDROM_SET}" == "3" ]] ; then
		cp "${CDROM_ROOT}"/resource.1 resource.x || die "cp"
		lha xfq resource.x || die "lha resource.x"
	fi

	# Prepare pak0 from the demo data, to ensure it is version 1.06
	# rather than 1.01.
	# http://linux.omnipotent.net/article.php?article_id=11287
	unpack ${A}
	# Need to rename, otherwise lha moans:
	# "LHa: Error: Checksum error (LHarc file?)"
	mv -f resource.{1,x} || die
	# "lha xqf resource.x" gives error:  "lha: invalid option -- q"
	# Creates id1/pak0.pak
	lha xfq resource.x || die "lha demo resource.x"

	if use vispatch; then
		mv ID1.VIS id1.vis
		vispatch -dir ${S}/id1 -data ${S}/id1.vis || die "vispatch failed"
	fi
}

src_install() {
	insinto "${GAMES_DATADIR}"/quake1/id1
	case "${CDROM_SET}" in
		0)  doins "${CDROM_ROOT}"/id1/pak1.pak || die "doins pak1.pak"
		    dodoc "${CDROM_ROOT}"/*.txt
		    ;;
		1|3)doins id1/pak1.pak || die "doins pak1.pak"
		    dodoc *.txt
		    ;;
		2)  newins "${CDROM_ROOT}"/Setup/ID1/PAK1.PAK pak1.pak \
				|| die "newins pak1.pak"
		    dodoc "${CDROM_ROOT}"/Docs/*
		    ;;
	esac

	# Using pak0.pak from the demo data
	doins id1/pak0.pak || die "doins pak0.pak"

	prepgamesdirs
}
