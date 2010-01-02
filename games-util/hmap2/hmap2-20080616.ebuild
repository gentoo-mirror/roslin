# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Maps compiler with colored lighting and lots of other features."
HOMEPAGE="http://icculus.org/twilight/darkplaces/"
SRC_URI="http://icculus.org/twilight/darkplaces/files/${PN}build${PV}.zip"

LICENSE="blob"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-arch/zip"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s|UNIX_LDFLAGS=-lm|UNIX_LDFLAGS=-lm ${LDFLAGS}|" \
		-e "s|-MD -Wall -O2|-Wall ${CFLAGS}|" \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"

	dodoc *.txt || die "dodoc failed"

	prepgamesdirs
}
