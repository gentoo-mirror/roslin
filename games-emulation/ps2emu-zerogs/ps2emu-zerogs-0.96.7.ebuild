# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games autotools

PCSX2="pcsx2-0.9.4"

DESCRIPTION="PS2Emu ZeroGS OpenGL plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="mirror://sourceforge/pcsx2/${PCSX2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug devbuild sse2"

RDEPEND="media-gfx/nvidia-cg-toolkit
	media-libs/glew
	media-libs/jpeg
	sys-libs/zlib
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXxf86vm
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xf86vidmodeproto"

S="${WORKDIR}/${PCSX2}/plugins/gs/zerogs/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -r -i \
		-e 's/-O[0-9]\b//g' \
		-e 's/-fomit-frame-pointer\b//g' \
		-e 's/C(..)?FLAGS=/C\1FLAGS+=/' \
		configure.ac || die

	eautoreconf -v --install || die
	chmod +x configure
}

src_compile() {
	egamesconf  \
		$(use_enable devbuild) \
		$(use_enable debug) \
		$(use_enable sse2) \
		|| die

	emake || die
}

src_install() {
	exeinto "`games_get_libdir`/ps2emu/plugins"
	insinto "`games_get_libdir`/ps2emu/plugins"
	doexe libZeroGSogl*.so.* || die
	doins ps2hw.fx Win32/ps2hw.dat || die
	dodoc README.txt || die
	prepgamesdirs
}
