# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="Maps compiler with colored lighting and lots of other features."
HOMEPAGE="http://icculus.org/twilight/darkplaces/"
SRC_URI="http://icculus.org/twilight/darkplaces/files/${PN}build${PV}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/zip"
RDEPEND=""

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e "s.-lpthread -lm.-lpthread -lm ${LDFLAGS}." \
		-e "s.-MD -Wall -g -ggdb.${CFLAGS}." \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"

	dodoc *.txt || die "dodoc failed"

	prepgamesdirs
}
