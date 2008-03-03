# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/methane/methane-1.4.7.ebuild,v 1.2 2005/05/31 20:47:5$

inherit games

DESCRIPTION="A futuristic ball game with simple rules"
HOMEPAGE="http://benny.kramekweb.com/machineball/"
SRC_URI="http://benny.kramekweb.com/machineball/${PN}-src-${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-libs/allegro-4.0.2
	>=media-libs/allegrogl-0.1.12
	>=media-libs/dumb-0.9.1
	>=media-libs/aldumb-0.9.1
	>=dev-games/ode-0.035"

src_unpack() {
	unpack $A
}

src_compile() {
	S="${WORKDIR}/${PN}-src"
        cd "${S}"
	make
}

src_install() {
	S="${WORKDIR}/${PN}-src"
	cd "${S}"
	dogamesbin machineball || die "dogamesbin failed"
	dodoc README
	insinto /usr/share/pixmaps
	doins machineball-icon-64x64.xpm
}

