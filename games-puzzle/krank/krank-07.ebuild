# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/krank/krank-07.ebuild,v 1.1 2009/09/4 10:01:25 AnViar Exp $

EAPI=2

inherit games

DESCRIPTION="Little casual game"
HOMEPAGE="http://krank.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_prepare() {
	rm src/*.pyc
	rm levels/*.pyc
	sed -i \
		-e "s/\`dirname \$0\`/\/usr\/share\/${PN} \ncd \/usr\/share\/${PN}/" \
		"${S}"/krank || die "sed failed"
}

src_install() {
	insinto /usr/share/${PN}/
	doins -r src sounds levels fonts art || die "doins failed"
	dogamesbin krank || die "dogamesbin failed"
	make_desktop_entry ${PN} "Krank" "/usr/share/${PN}/levels/images/icon64x64.png"
}
