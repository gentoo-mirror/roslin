# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

MY_PN=SpacePhallus

DESCRIPTION="Fun shoot-em-up with a retro 8 bit theme"
HOMEPAGE="http://www.charliesgames.com/wordpress/?page_id=65"
SRC_URI="http://www.charliesgames.com/phallus/${MY_PN}Linux.tar.gz"

# Space Phallus is binary blob, no license included
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}Linux

src_install() {
	newgamesbin ${MY_PN} ${PN} || die "newgamesbin failed"
	dodoc *txt || die "dodoc failed"

	prepgamesdirs
}
