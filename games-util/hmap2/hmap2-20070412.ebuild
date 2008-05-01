# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PN="${PN/2/}"

DESCRIPTION="Maps compiler with colored lighting and lots of other features."
HOMEPAGE="http://icculus.org/twilight/darkplaces/"
SRC_URI="http://icculus.org/twilight/darkplaces/files/${MY_PN}${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-arch/zip"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	sed -i \
		-e "s|UNIX_LDFLAGS=-lm|UNIX_LDFLAGS=-lm ${LDFLAGS}|" \
		-e "s|-Wall -O2 -Icommon|-Wall -Icommon ${CFLAGS}|" \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin bin/hlight || die "dogamesbin failed"
	dogamesbin bin/hvis || die "dogamesbin failed"
	dogamesbin bin/hqbsp || die "dogamesbin failed"

	dodoc *.txt || die "dodoc failed"

	prepgamesdirs
}
