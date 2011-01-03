# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion games

DESCRIPTION="You control a psychic bodyguard, and try to protect the VIP"
HOMEPAGE="http://home.gna.org/blackshadeselite/"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/blackshadeselite/trunk"
ESVN_PROJECT="blackshadeselite"

LICENSE="blackshades"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libvorbis
	media-libs/openal
	media-libs/freealut
	media-libs/libsdl"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
	sed -i \
		-e "s|-O2 -fstrict-aliasing -Wall|${CFLAGS}|" \
		Makefile || die "sed"

	epatch "${FILESDIR}"/${PN}-gcc43.patch
}

src_install() {
	newgamesbin objs/blackshades ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r Data || die "doins failed"
	dodoc IF_THIS_IS_A_README_YOU_HAVE_WON Readme TODO \
		 || die "dodoc failed"
	make_desktop_entry ${PN} "Black Shades Elite"
	prepgamesdirs
}
