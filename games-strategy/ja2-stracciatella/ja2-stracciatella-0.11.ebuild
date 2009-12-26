# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib games

DESCRIPTION="An enhanced port of Jagged Alliance 2 to SDL"
HOMEPAGE="http://ja2.dragonriders.de/"
SRC_URI="http://tron.homeunix.org/ja2/ja2-${PV}-source.tar.bz2"

LICENSE="SFI-SCLA"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="linguas_nl linguas_en linguas_fr linguas_de linguas_it linguas_pl
linguas_ru linguas_ru_gold"

RDEPEND="sys-libs/zlib
	media-libs/libsdl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/ja2-${PV}"
SGPDATADIR="${GAMES_PREFIX_OPT}/${PN}"

pkg_setup() {
	games_pkg_setup

	langcount=0
	for i in ${LINGUAS}
	do
		let $((++langcount))
		if [[ $langcount = 2 ]]
		then
			eerror "${PN} only supports one localization at once!"
			die "Localization is only supported when ${PN} is in a single language!"
		fi

		case ${i} in
			nl) LNG=DUTCH;;
			fr) LNG=FRENCH;;
			de) LNG=GERMAN;;
			it) LNG=ITALIAN;;
			pl) LNG=POLISH;;
			ru) LNG=RUSSIAN;;
			ru_gold) LNG=RUSSIAN_GOLD;;
			*) LNG=ENGLISH;;
		esac
	done
}

src_compile() {
	use amd64 && multilib_toolchain_setup x86

	emake LNG=${LNG} WITH_ZLIB=1 || die "emake"
}

src_install() {
	mkdir -p "${D}/${SGPDATADIR}"
	cp ja2 "${D}/${SGPDATADIR}/"

	newgamesbin "${FILESDIR}/ja2-wrapper.sh" ja2 || die "newgamesbin ${PN} failed"

	doman ja2.6
	dodoc Changelog TODO

	doicon "${FILESDIR}/${PN}.png"
	make_desktop_entry "ja2 -fullscreen" "Jagged Alliance 2 - Stracciatella"

	prepgamesdirs
}

pkg_postinst() {
	elog "Remember to place your datafiles in $SGPDATADIR, converted to
	lowercase."
	elog "For more information see $HOMEPAGE"
}
