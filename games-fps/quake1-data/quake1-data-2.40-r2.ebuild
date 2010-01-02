# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="iD Software's Quake 1 ... the data files"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake/"
SRC_URI="mirror://idsoftware/quake/quake106.zip
	vispatch? ( mirror://sourceforge/vispatch/id1_vis.tgz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="vispatch"

DEPEND="app-arch/lha
	vispatch? ( games-util/vispatch )"
RDEPEND="!games-fps/quake1-demodata[symlink]"

S=${WORKDIR}

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
	unpack quake106.zip

	# Need to rename, otherwise lha moans:
	# "LHa: Error: Checksum error (LHarc file?)"
	mv -f resource.{1,x} || die

	# "lha xqf resource.x" gives error:  "lha: invalid option -- q"
	# Creates id1/pak0.pak
	lha xfq resource.x || die "lha demo resource.x"

	case "${CDROM_SET}" in
		0)	cp "${CDROM_ROOT}"/id1/pak1.pak id1/ \
				|| die "cp pak1.pak" ;;
		2)	cp "${CDROM_ROOT}"/Setup/ID1/PAK1.PAK id1/pak1.pak \
				|| die "cp pak1.pak" ;;
	esac

	if use vispatch; then
		unpack id1_vis.tgz
		mv ID1.VIS id1.vis
		vispatch -dir id1 || die "vispatch failed"
	fi
}

src_install() {
	case "${CDROM_SET}" in
		0)	dodoc "${CDROM_ROOT}"/*.txt ||
			dodoc /usr/share/doc/quake1-data-*/* ;;
		1|3)	dodoc *.txt ;;
		2)	dodoc "${CDROM_ROOT}"/Docs/* ;;
	esac

	insinto "${GAMES_DATADIR}"/quake1/id1
	doins id1/pak[0-1].pak || die "doins pak[0-1].pak"

	prepgamesdirs
}
