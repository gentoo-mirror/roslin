# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.2.ebuild,v 1.3 2004/11/22 20:37:06 plasmaroo Exp $

inherit games subversion

ESVN_REPO_URI="http://svn.bountysource.com/vbam/trunk/"
ESVN_PROJECT="vbam"

DESCRIPTION="A VBA fork that focuses on consolidating existing ports and improving VBA in general"
HOMEPAGE="http://vba-m.ngemu.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="zip"

RDEPEND="!games-emulation/visualboyadvance
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl"

S="${WORKDIR}/${PN}"

src_unpack() {
	subversion_src_unpack
	cd ${S}
	
	sed -i \
	    -e "s|-O3|${CFLAGS}|" Makefile \
	    || die "sed failed"

	if use zip; then
		sed -i \
		-e "s|-DSDL|-DSDL -DUSEFEX|" Makefile \
		|| die "sed failed"
	fi
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${GAMES_PREFIX}" install || die "make install failed"
	dodoc doc/DevInfo.txt "doc/Known Bugs.txt" doc/ReadMe.txt doc/authors.txt doc/todo.txt
	
	prepgamesdirs
}
