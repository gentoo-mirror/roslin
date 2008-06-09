# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="An easy, self-contained Sony Playstation emulator"
HOMEPAGE="http://psxemulator.gazaxian.com/"
SRC_URI="http://psxemulator.gazaxian.com/pSX_linux_${PV/./_}.tar.bz2"

LICENSE="pSX-unknown-license"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/${PN}/pSX"

DEPEND=""
RDEPEND="dev-libs/libxml2
	virtual/opengl
	media-libs/alsa-lib
	>=x11-libs/gtk+-2.10.14
	x11-libs/gtkglext"

S=${WORKDIR}/pSX

src_install() {
	local dir="${GAMES_PREFIX_OPT}"/${PN}

	insinto "${dir}"
	doins -r pSX bios cdimages || die "doins failed"
	fperms a+x "${dir}/pSX"
	games_make_wrapper psx ./pSX "${dir}"
	keepdir "${dir}"/{bios,cdimages}
	dodoc readme.txt
	prepgamesdirs
}
