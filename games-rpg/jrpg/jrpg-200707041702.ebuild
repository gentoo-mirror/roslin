# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python games

# convert version into YYYY-mm-DD-HH-MM format
MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}-${PV:8:2}-${PV:10:2}"

DESCRIPTION="A kanji learning game styled after the classic SNES RPG games"
HOMEPAGE="http://taw.chaosforge.org/jrpg/"
SRC_URI="http://taw.chaosforge.org/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="jrpg"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygame"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
dir="${GAMES_DATADIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-savedir.patch"
}

src_install() {
	insinto "${GAMES_DATADIR}"
	doins -r "../${PN}"
	fperms a+x "${dir}/jrpg.py"
	games_make_wrapper jrpg ./jrpg.py "${dir}"

	rm "${D}/${dir}/"{DESIGN,README}
	dodoc DESIGN README || die "dodoc failed"

	make_desktop_entry "${PN}" "jRPG" "${PN}" "Game;Education;RolePlaying;;"
}

pkg_postinst() {
	python_mod_optimize "${dir}"
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup
}
