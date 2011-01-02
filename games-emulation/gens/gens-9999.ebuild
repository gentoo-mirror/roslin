# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.12a.ebuild,v 1.7 2004/07/01 11:14:31 eradicator Exp $

EAPI=2

inherit autotools games cvs

DESCRIPTION="A Sega Genesis/CD/32X emulator"
HOMEPAGE="http://gens.consolemul.com/"
SRC_URI=""

ECVS_SERVER="${PN}.cvs.sourceforge.net:/cvsroot/${PN}"
ECVS_MODULE="Gens-MultiPlatform"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="opengl"

RDEPEND=">=media-libs/libsdl-1.2[opengl?]
	>=x11-libs/gtk+-2.4.0
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98
	!games-emulation/gens-gs"

S="${WORKDIR}/Gens-MultiPlatform/linux"

src_prepare() {
	eautoreconf
}

src_configure() {
	egamesconf $(use_with opengl) || die "econf failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS INSTALL README gens.txt history.txt
	prepgamesdirs
}
