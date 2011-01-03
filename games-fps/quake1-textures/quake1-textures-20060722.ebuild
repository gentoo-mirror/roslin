# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_SKINS="SKINSbmodels-48files-4-23-05.zip"
RYGEL_F="rygel-dp-texturepack-high.pk3"

DESCRIPTION="Collection of graphical improvements for Quake 1"
HOMEPAGE="http://facelift.quakedev.com/"
SRC_URI="http://facelift.quakedev.com/download/${MY_SKINS}
	http://shub-hub.com/files/textures_replacement/${RYGEL_F}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="demo fuhquake tenebrae"

RDEPEND="|| (
		games-fps/darkplaces
		tenebrae? ( games-fps/tenebrae )
		games-fps/ezquake-bin
		fuhquake? ( games-fps/fuhquake-bin ) )"
DEPEND="app-arch/unzip"

S=${WORKDIR}
dir=${GAMES_DATADIR}/quake1

src_unpack() {
	unpack ${MY_SKINS}

	# Move the skin textures to join the others
	mkdir -p textures
	mv -f *.tga textures

	ln -s "${DISTDIR}"/${RYGEL_F} ${RYGEL_F}.zip || die "ln rygel"
	unpack ./${RYGEL_F}.zip || die "unpack rygel"
}

src_install() {
	insinto "${dir}"/id1
	doins -r textures || die "doins textures"

	# Added by rygel. Ignoring gfx & maps & cubemaps.
	# cubemaps dir is added by darkplaces.
	doins -r env progs || die "doins rygel"

	if use demo ; then
		keepdir "${dir}/demo"
		# Set up symlink, for the demo levels to include the textures
		dosym "${dir}/id1/textures" "${dir}/demo/textures"
	fi

	# Support specific engines which need their own directory names
	if use tenebrae ; then
		keepdir "${dir}/tenebrae"
		dosym "${dir}/id1/textures" "${dir}/tenebrae/override"
	fi
	if use fuhquake ; then
		keepdir "${dir}/fuhquake"
		dosym "${dir}/id1/textures" "${dir}/fuhquake/textures"
	fi

	dodoc *.txt || die "dodoc"

	prepgamesdirs
}
