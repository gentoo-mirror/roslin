# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION=""
HOMEPAGE="http://ta3d.sourceforge.net/"
SRC_URI="http://ta3d.darkstars.co.uk/releases/${PN}-v-0-4-1.7z"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/allegro-4.2
	>=media-libs/allegrogl-0.4.0
	media-libs/fmod:1"
DEPEND="${RDEPEND}
	app-arch/p7zip"

S=${WORKDIR}/${PN}

src_compile() {
	egamesconf \
		--disable-allegrotest || die "econf failed"
	emake || die "emake failed"
}
