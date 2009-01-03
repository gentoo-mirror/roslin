# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games eutils

DESCRIPTION="Addictive, multi-player 'board' game. It's easy to learn to play."
HOMEPAGE="http://fruise.googlepages.com/reaction.html"
SRC_URI="http://fruise.googlepages.com/${P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="single"

DEPEND="media-libs/libsdl
	single? ( dev-lang/fpc )"
RDEPEND="${DEPEND}"

dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/"${P}"-Makefile.patch

	if use !single ; then
		sed -i \
			-e "s|reaction : main.c|reaction2 : main.c|" \
			-e "s|reaction1 : main.c|reaction : main.c|" \
		Makefile || die "sed Makefile failed"
	fi
}

src_install() {
	insinto "${dir}"
	doins -r data || die "doins data failed"

	if use single ; then
		dodir "${dir}"/YACRAI
		insinto "${dir}"/YACRAI
		doins YACRAI/libyacrai*
	fi

	exeinto "${dir}"
	doexe ${PN}

	dodoc CHANGELOG README

	games_make_wrapper ${PN} ./${PN} "${dir}"

	make_desktop_entry ${PN} "Reaction"

	prepgamesdirs
}

pkg_postinst() {
	if use single ; then
		ewarn "WARNING! Computer player may be VERY slow due to some error code"
		ewarn "Please refer to the QA Notice for more info"
	fi
}
