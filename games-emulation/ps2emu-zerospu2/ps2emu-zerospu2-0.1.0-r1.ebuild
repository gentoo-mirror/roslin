# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games autotools

PCSX2="pcsx2-0.9.4"

DESCRIPTION="Zero PS2Emu sound plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="mirror://sourceforge/pcsx2/${PCSX2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-libs/alsa-lib
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PCSX2}/plugins/spu2/zerospu2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	
	sed -r -i \
		-e '/C(..)?FLAGS=/d' \
		-e 's/-O[0-9]\b//g' \
		-e 's/-fomit-frame-pointer\b//g' \
		-e 's/C(..)?FLAGS\+="/C\1FLAGS+=" /' \
		configure.ac || die

	# A fix for GCC 4.3
	epatch "${FILESDIR}"/${PN}-gcc43.patch

	eautoreconf -v --install || die
}

src_compile() {
	egamesconf `use_enable debug` || die
	emake || die
}

src_install() {
	exeinto "`games_get_libdir`/ps2emu/plugins"
	doexe libZeroSPU2.so.${PV} || die
	prepgamesdirs
}
