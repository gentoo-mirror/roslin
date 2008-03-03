# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils games

MY_PN="${PN/-data/}"

DESCRIPTION="Kart racing tracks, sound and stuff."
HOMEPAGE="http://www.top10-racing.org/tiki-index.php"
SRC_URI="http://download.savannah.nongnu.org/releases/${MY_PN}/${MY_PN}-ubuntu7.04-32-full-rel${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${MY_PN}-all-${PV/2008/08}

dir=${GAMES_DATADIR}/${MY_PN}

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	rm -r \
		data/*/CVS \
		data/track_data/*/textures/skybox/Thumbs.db \
		|| die "rm failed"
}

src_install() {
	insinto "${dir}"
	doins -r data || die "doins failed"

	prepgamesdirs
}
