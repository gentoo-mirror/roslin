# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# shade <shade.poczta@gmail.com>

inherit eutils games

MY_MOD="rebalance"
MY_GAME="warzone2100"

DESCRIPTION="Warzone 2100 rebalance mod by Zarel"
HOMEPAGE="http://wzguide.co.cc/new/"
SRC_URI="http://guide.wz2100.net/new/rebalance_${PV}.wz"

LICENSE="CC0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"
RDEPEND="<games-strategy/${MY_GAME}-2.2"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${MY_MOD}_${PV}.wz" "${S}" || die "cp failed"
}

src_install() {
	insinto "${GAMES_DATADIR}/${MY_GAME}"/mods/global
	newins "${MY_MOD}_${PV}.wz" "${MY_MOD}.wz" || die "newins failed"
	make_desktop_entry "${MY_GAME} --mod=${MY_MOD}.wz" "Warzone 2100 - ${MY_MOD}" warzone2100.png
	prepgamesdirs
}


pkg_postinst() {
	elog "To start ${MY_GAME} rebalance mod type:"
	elog " warzone2100 --mod=rebalance.wz"
	elog " "
	elog "You can't play campagins while this mod is started"
	elog "It's known bug. Dont ask about it."
}
